#' Play midi from midi frame
#'
#' Transform the midi file to fileext format and provide a play button for html
#' documents.
#'
#' @param mfr r_midi_frames object
#' @param audiofile audiofile
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' midi_file_string <- system.file("example_files", "Bass_sample.mid", package="tuneR")
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mfr <- r_midi_frames(midi_file_string)
#' mfr %>% play_midi_frame()
#' }
play_midi_frame <- function(
  mfr,
  audiofile = tempfile("mf_out_", fileext = ".wav")
) {
  filetype <- audiofile %>%
    stringr::str_sub(-3L) %>%
    match.arg(c("wav", "mp3"))

  filestem <- audiofile %>% stringr::str_sub(end = -5L)

  wavfile <- paste0(filestem, ".wav")
  mp3file <- paste0(filestem, ".mp3")
  midfile <- paste0(filestem, ".mid")

  mfr$mf$write_file(midfile)
  raudiomate::synthesize_midi(midfile, wavfile)
  message("(Hopefully) created midi and audio file ", midfile, " and synthesized ", wavfile, ".")

  if (filetype == "mp3") {
    raudiomate::convert_to_mp3(wavfile)
    message("(Hopefully) created mp3 file ", mp3file, ".")
  }


  raudiomate::play_button(audiofile, filetype)
}

