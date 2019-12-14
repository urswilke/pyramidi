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
    miditapyr$mido_midi_df()
}
