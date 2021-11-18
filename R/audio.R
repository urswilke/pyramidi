#' Play midi from midi frame
#'
#' Transform the midi file to fileext format and provide a play button for html
#' documents.
#'
#' @param mfr r_midi_frames object
#' @param audiofile audiofile
#' @param overwrite logical; defaults to FALSE;
#' if file exists and overwrite = FALSE, the existing files will be used and nothing
#' is synthesized/converted to audio files.
#'
#' @return Retuns an audio html tag that can be embeded in (rmarkdown) html
#'   documents to play the midi data.
#' @noRd
#'
#' @examples
#' \dontrun{
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mfr <- r_midi_frames(midi_file_string)
#' mfr %>% play_midi_frame()
#' }
play_midi_frame <- function(
  mfr,
  audiofile = tempfile("mf_out_", fileext = ".wav"),
  overwrite = FALSE
) {
  filetype <- audiofile %>%
    stringr::str_sub(-3L) %>%
    match.arg(c("wav", "mp3"))

  filestem <- audiofile %>% stringr::str_sub(end = -5L)

  wavfile <- paste0(filestem, ".wav")
  mp3file <- paste0(filestem, ".mp3")
  midfile <- paste0(filestem, ".mid")

  if (overwrite | !file.exists(midfile)) {
    mfr$mf$write_file(midfile)
  }
  if (overwrite | !file.exists(wavfile)) {
    raudiomate::synthesize_midi(midfile, wavfile)
  }
  if ((overwrite | !file.exists(mp3file)) & filetype == "mp3") {
    raudiomate::convert_to_mp3(wavfile)
    message("(Hopefully) created mp3 file ", mp3file, ".")
  }
  message("(Hopefully) created midi and audio file ", midfile, " and synthesized ", wavfile, ".")


  raudiomate::player(audiofile, filetype)
}

