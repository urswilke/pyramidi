#' read midi file via mido
#'
#' @param mid_file file path name
#'
#' @return
#' @export
#'
#' @examples
mido_midi <- function(mid_file) {
  mido$MidiFile(mid_file)
}
# mid_file = '/home/chief/Bitwig Studio/Projects/bossa_raw/midi_arpeggiated.mid'


#' Tabulate midi file data in data frames
#'
#' @param mid_file file path
#'
#' @return
#' @export
#'
#' @examples
#'
midi_df <- function(mid_file) {
  mido_midi(mid_file) %>%
    miditapyr$mido_midi_df() %>%
    purrr::map(tibble::as_tibble) %>%
    purrr::set_names(c("df_meta", "df_notes", "ticks_per_beat"))
}

#' Write
#'
#' @param df_meta
#' @param df_notes
#' @param ticks_per_beat
#'
#' @return
#' @export
#'
#' @examples
df2midi <- function(df_meta,
                    df_notes,
                    ticks_per_beat,
                    file) {
  miditapyr$df_2_midi(df_meta %>%
                        dplyr::mutate(time = as.integer(time)),
                      df_notes %>%
                        dplyr::mutate(time = as.integer(time)),
                      ticks_per_beat %>%
                        dplyr::pull(),
                      file)
  # Create mido MidiFile object:
  # mf <- miditapyr$df2mido_midifile(df_meta,
  #                                  df_notes,
  #                                  ticks_per_beat %>%
  #                                    dplyr::pull())
  # mf$save(file)
}
