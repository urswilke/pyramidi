#' Tabulate time signature
#'
#' @param df_meta data.frame containing midi meta event data resulting of miditapyr$mido_midi_df()
#'
#' @return
#'
#' @examples
#' library(zeallot)
#' mt <- reticulate::import("miditapyr")
#' mido <- reticulate::import("mido")
#' mid_file <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mido$MidiFile(mid_file) %>%
#'   mt$mido_midi_df()  %->% c(df_meta, df_notes, ticks_per_beat)
#' tab_time_sig(df_meta)
tab_time_sig <- function(df_meta) {
  df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(type =="time_signature") %>%
    dplyr::select(numerator, denominator, clocks_per_click, notated_32nd_notes_per_beat)
}

#' Get tempo
#'
#' @param df_meta data.frame containing midi meta event data resulting of miditapyr$mido_midi_df()
#'
#' @return
#'
#' @examples
#' library(zeallot)
#' mt <- reticulate::import("miditapyr")
#' mido <- reticulate::import("mido")
#' mid_file <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mido$MidiFile(mid_file) %>%
#'   mt$mido_midi_df()  %->% c(df_meta, df_notes, ticks_per_beat)
#' get_tempo(df_meta)
get_tempo <- function(df_meta) {
  df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(type =="set_tempo") %>%
    dplyr::pull(tempo)
}
get_ticks2second_scale <- function(df_meta, ticks_per_beat) {
  get_tempo(df_meta) * 1e-6 / ticks_per_beat
}
#' Get beats per minute
#'
#' @param df_meta  data.frame containing midi meta event data resulting of miditapyr$mido_midi_df()
#'
#' @return integer of beats per minute
#' @export
#'
#' @examples
#' library(zeallot)
#' mt <- reticulate::import("miditapyr")
#' mido <- reticulate::import("mido")
#' mid_file <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mido$MidiFile(mid_file) %>%
#'   mt$mido_midi_df()  %->% c(df_meta, df_notes, ticks_per_beat)
#' get_bpm(df_meta)
get_bpm <- function(df_meta) {
  60 * 1e6 / get_tempo(df_meta)
}
