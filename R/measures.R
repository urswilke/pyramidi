#' Tabulate measure related data in the midi event data
#'
#' This function mainly adds \code{ticks} which is the absolute value of mido's
#' \code{time} (measured in ticks) for every track. Furthermore, this absolute
#' time value is translated to the further columns of beats (quarter notes;
#' \code{"b"}), measures (bars; \code{"m"}) and the time in seconds (\code{"t"}).
#' The function outputs these additional columns only if they are specified in
#' the argument \code{columns_to_add} (see details).
#'
#' The function transforms the unnested midi frame by first transforming the
#' midi time (measured in ticks passed relative to the previous event) to
#' absolute time for every track. Also the auxiliary variable \code{i_note} is
#' added (indexing the occurrence of each note for every track). This is needed
#' to allow to pivot the notes to wide format and back to long with
#' \code{pivot_wide_notes()} and \code{pivot_long_notes()}.
#' \itemize{
#'   \item{m: measure (bar)}
#'   \item{b: beat (quarter note)}
#'   \item{t: time in seconds}
#' }
#'
#' @param df Note event data.frame resulting of miditapyr$unnest_midi()
#' @param ticks_per_beat integer resulting of miditapyr$mido_midi_df()
#' @param columns_to_add Character vector of the columns to be added to the result
#'   (see section "Details"). Subset of \code{c("m", "b", "t", "time")}.
#'
#' @return A data.frame with the following columns added:
#'  \code{ticks}, \code{i_note} and the columns specified in \code{columns_to_add}.
#'
#'
#' @export
#'
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' tab_measures(df, ticks_per_beat)
#' }
tab_measures <- function(df, ticks_per_beat, columns_to_add = "b") {
  if (is.null(df)) {
    return(NULL)
  }
  possible_cols <- c("m", "b", "t", "time")
  columns_to_add <- match.arg(columns_to_add, possible_cols, several.ok = TRUE)
  columns_to_remove <- setdiff(possible_cols, columns_to_add)
  cols_to_put_last <- c(
    "tempo", "numerator", "denominator", "clocks_per_click", "notated_32nd_notes_per_beat"
  )

  df %>%
    tibble::as_tibble() %>%
    dplyr::group_by(i_track) %>%
    dplyr::mutate(ticks = cumsum(time)) %>%
    dplyr::mutate(t = ticks * get_ticks2second_scale(df, ticks_per_beat)) %>%
    dplyr::mutate(m = t * get_bpm(df) / 60) %>%
    # TODO: generalize for if there are several time signatures in the midi file!
    # the "[1]" only takes the first time signature if several in file:
    dplyr::mutate(b = m * tab_time_sig(df)$numerator[1]) %>%
    dplyr::group_by(i_track, note) %>%
    dplyr::mutate(i_note = cumsum(stringr::str_detect(type, "^note_on$")) |> as.integer()) %>%
    dplyr::ungroup() %>%
    dplyr::select(-!!columns_to_remove) %>%
    dplyr::relocate(!!cols_to_put_last, .after = dplyr::last_col())
}

