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
    # TODO: generalize for several
    # the "[1]" only takes the first time signature if several in file:
    dplyr::mutate(b = .data$m * tab_time_sig(df)$numerator[1]) %>%
    # mutate(track = cumsum(str_detect(type, "track_name" ))) %>%
    # dplyr::filter(stringr::str_detect(.data$type, "^note_o[nf]f?$")) %>%
    dplyr::group_by(.data$i_track, .data$note) %>%
    # mutate(i_note = cumsum(ifelse(type == "^note_on$", 1, 0))) %>%
    dplyr::mutate(i_note = cumsum(stringr::str_detect(.data$type, "^note_on$"))) %>%
    dplyr::ungroup()
  # %>%
  #   # select(-tempo, -numerator, -denominator, -clocks_per_click, -notated_32nd_notes_per_beat) %>%
  #   dplyr::select(c("i_track", "name", "channel", "type", "m", "b", "t", "ticks", "time", "note", "velocity", "i_note"))

}


# classify_beat_patterns <- function(df_plot) {
#
#   l <-
#     df_plot %>%
#     dplyr::filter(i_track == 1) %>%
#     dplyr::group_split(round(m_note_on %/% 2, 8), round(m_note_off %/% 2, 8)) %>%
#     purrr::map(~dplyr::select(.x, i_track, note, m_note_on, m_note_off) %>%
#                  dplyr::mutate(m_note_on = round(m_note_on %% 2, 6),
#                                m_note_off = round(m_note_off %% 2))) %>%
#     purrr::set_names()
#
#   lu <-
#     unique(l) %>%
#     purrr::set_names()
#
#   classes <- factor(names(l), names(lu)) %>% as.numeric() #%>% tidyr::replace_na()
#
#   # min_note <- df_plot %>% dplyr::filter(i_track == 1,note == min(df_plot %>% dplyr::filter(i_track == 1) %>% dplyr::pull(note))) %>% dplyr::pull(note_name) %>% unique()
#   # max_note <- df_plot %>% dplyr::filter(i_track == 1,note == max(df_plot %>% dplyr::filter(i_track == 1) %>% dplyr::pull(note))) %>% dplyr::pull(note_name) %>% unique()
#   df_beats <-
#     (1:floor(max(df_plot$m_note_off) / 2) * 2) %>%
#     tibble::tibble(m_note_off = .) %>%
#     dplyr::mutate(note_name = "pattern",
#            note_name_max = "pattern2",
#            pattern = classes,
#            i_track = 1,
#            m_note_on = lag(m_note_off, default = 0) %>% as.vector())
#   df_beats
# }

