#' write note_on and _off events in the same line (long to wide)
#'
#' @param df_measures data.frame resulting of miditapyr$mido_midi_df() and then running tab_measures() (see example)
#'
#' @return A data.frame with the following columns pivoted to wide: c("m", "b", "t", "ticks", "time", "velocity"). Every column is pivoted to wide with the suffix "_note_on" & "_note_off" showing the values of the original column as a prefix. See \code{?tab_measures} for an explanation of the meaning of these columns.
#'
#' @export
#'
#' @examples
#' mt <- reticulate::import("miditapyr")
#' mido <- reticulate::import("mido")
#' mid_file_str <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mido_mid_file <- mido$MidiFile(mid_file_str)
#' dfc <- mt$midi_to_df(mido_mid_file)
#' ticks_per_beat = mido_mid_file$ticks_per_beat
#' dfm <- dfc %>%
#'   mt$tidy_df() %>%
#'   tab_measures(ticks_per_beat)
#' dfm %>% widen_events()
widen_events <- function(df_measures) {
  df_measures %>%
    dplyr::select(c("i_track", "channel", "type", "m", "b", "t", "ticks", "time", "note", "velocity", "i_note")) %>%
    # dplyr::select(c("i_track", "name", "channel", "type", "m", "b", "t", "ticks", "time", "note", "velocity", "i_note")) %>%
    tidyr::pivot_wider(names_from = c("type"), values_from = c("m", "b", "t", "ticks", "time", "velocity")) %>%
    # as.data.frame() %>%
    dplyr::arrange(.data$i_track, .data$b_note_on)
}
