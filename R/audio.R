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
#' @param soundfont path to sf2 sound font (character string); if not specified,
#'   the default soundfont of the fluidsynth package (`fluidsynth::soundfont_path()`) will be (downloaded if not present and) used.
#' @param verbose logical whether to print command line output; defaults to FALSE
#' @param live logical; if `TRUE` the synthesized midi is directly played in 
#'   the console. If `FALSE` an audio html tag is written. This will generate 
#'   a small audio player in a knitr Rmd document (and probably also Quarto qmd files).
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
  overwrite = TRUE,
  soundfont = fluidsynth::soundfont_path(),
  verbose = FALSE,
  live = interactive()
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
  if (live) {
    fluidsynth::midi_play(
      midfile,
      soundfont
    )
    return(NULL)
  }
  if (overwrite | !file.exists(wavfile)) {
    fluidsynth::midi_convert(
      midfile,
      soundfont = soundfont,
      output = wavfile
    )
  }
  if ((overwrite | !file.exists(mp3file)) & filetype == "mp3") {
    av::av_audio_convert(wavfile, mp3file, verbose = verbose)
    message("(Hopefully) created mp3 file ", mp3file, ".")
  }
  message("(Hopefully) created midi and audio file ", midfile, " and synthesized ", wavfile, ".")

  player(audiofile, filetype)
}

#' Play midi file
#'
#' Transform the midi file to fileext format and provide a play button for html
#' documents.
#'
#' @param audiofile audiofile
#' @param fileext file extension
#'
#' @return html tag of a playbutton
#' @export
#'
#' @examples
#' \dontrun{
#' midifile <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' audiofile <- "test.wav"
#' mp3file <- "test.mp3"
#' fluidsynth::midi_convert(midifile, output = audiofile)
#' av::av_audio_convert(audiofile, mp3file)
#' audiofile %>% player()
#' }
player <- function(
    audiofile,
    fileext = "wav"
) {
  html_tag_audio(audiofile, fileext)
}

# from here: https://community.rstudio.com/t/audio-files-in-r-markdown/20874/3
html_tag_audio <- function(file, type = c("wav", "mp3")) {
  type <- match.arg(type)
  htmltools::tags$audio(
    controls = "",
    htmltools::tags$source(
      src = file,
      type = glue::glue("audio/{type}", type = type)
    )
  )
}