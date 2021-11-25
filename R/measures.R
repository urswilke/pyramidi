#' Tabulate measure related data in the midi event data
#'
#' @param df Note event data.frame resulting of miditapyr$unnest_midi()
#' @param ticks_per_beat integer resulting of miditapyr$mido_midi_df()
#'
#' @return A data.frame with the following columns added: c("m", "b", "t", "ticks", "time"). \cr
#'   m: measure \cr
#'   b: beat \cr
#'   t: time in seconds \cr
#'
#'
#' @export
#'
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' tab_measures(df, ticks_per_beat)
#' }
tab_measures <- function(df, ticks_per_beat) {
  if (is.null(df)) {
    return(NULL)
  }
  df %>%
    tibble::as_tibble() %>%
    dplyr::group_by(.data$i_track) %>%
    dplyr::mutate(ticks = cumsum(.data$time)) %>%
    dplyr::mutate(t = .data$ticks * get_ticks2second_scale(df, ticks_per_beat)) %>%
    dplyr::mutate(m = t * get_bpm(df) / 60) %>%
    # TODO: generalize for if there are several time signatures in the midi file!
    # the "[1]" only takes the first time signature if several in file:
    dplyr::mutate(b = .data$m * tab_time_sig(df)$numerator[1]) %>%
    dplyr::group_by(.data$i_track, .data$note) %>%
    dplyr::mutate(i_note = cumsum(stringr::str_detect(.data$type, "^note_on$"))) %>%
    dplyr::ungroup()
}
