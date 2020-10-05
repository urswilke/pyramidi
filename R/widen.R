#' write note_on and _off events in the same line (long to wide)
#'
#' @param df_measures
#'
#' @return
#' @export
#'
#' @examples
#' library(zeallot)
#' mid_file <- '/home/chief/Bitwig Studio/Projects/bossa_raw/midi_arpeggiated.mid'
#' mt <- reticulate::import("miditapyr")
#' mido <- reticulate::import("mido")
#' mido$MidiFile(mid_file) %>%
#'   mt$mido_midi_df()  %->% c(df_meta, df_notes, ticks_per_beat)
#'   tab_measures(df_meta, df_notes, ticks_per_beat) %>%
#'   widen_events()
widen_events <- function(df_measures) {
  df_measures %>%
    dplyr::select(c("i_track", "name", "channel", "type", "m", "b", "t", "ticks", "time", "note", "velocity", "i_note")) %>%
    tidyr::pivot_wider(names_from = c("type"), values_from = c("m", "b", "t", "ticks", "time", "velocity")) %>%
    # as.data.frame() %>%
    dplyr::arrange(i_track, b_note_on)
}
