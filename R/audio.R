#' Play midi file
#' 
#' @description Play midi from MidiFramer object.
#' Helper function to synthesize midi, either:
#'   * directly in the console,
#'   * or generate audio files and include a small player in html documents.
#'   
#' This helper function is also called in the `MidiFramer$play()` method.
#' 
#' WARNING: Setting `overwrite = TRUE` or `marie_kondo = TRUE` (the default!!) will DELETE the specified audio files!!!
#' (see more details below)
#'
#' @param midifile Path to the midi file to synthesize on; character string.
#' @param soundfont path to sf2 sound font (character string); if not specified,
#'   the default soundfont of the fluidsynth package (`fluidsynth::soundfont_path()`) will be (downloaded if not present and) used.
#' @param output Path to the audiofile to be synthesized. If audiofile of type mp3, it will
#' first be synthesized to wav, and then converted to mp3 the `av` package;
#' (character string).
#' @param overwrite logical; defaults to TRUE;
#' if file exists and overwrite = FALSE, the existing files will not be overwritten and the function errors out.
#' @param verbose logical whether to print command line output; defaults to FALSE
#' @param live logical; if `TRUE` the synthesized midi is directly played in 
#'   the console. If `FALSE` an audio html tag is written. This will generate 
#'   a small audio player when knitting an Rmd document 
#'   (and probably also Quarto qmd files; I didn't check).
#' @param marie_kondo logical, whether to remove intermediate files (the midi
#'   file, and if live = `FALSE` and `audiofile` is an mp3 it also 
#'   deletes the intermediate wav file); defaults to `TRUE`
#' @param ... Arguments passed to the fluidsynth functions 
#'   (`fluidsynth::midi_play` or `fluidsynth::midi_convert` 
#'   depending on the value of `live`).
#'   
#' @return If `live = TRUE`, nothing is returned. If `live = FALSE`, a html
#'   [audio tag](https://developer.mozilla.org/docs/Web/HTML/Element/audio) is returned that will render as a small audio player when knitting
#'   an Rmd document. The audio player can then play the generated `output` audio file.
#'   
#' @export
#' @examples
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' midi_file_string |> player()
#' 
#' # The player is a small helper function to do basically this:
#' \dontrun{
#' midifile <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' audiofile <- "test.wav"
#' mp3file <- "test.mp3"
#' fluidsynth::midi_convert(midifile, output = audiofile)
#' av::av_audio_convert(audiofile, mp3file)
#' # `marie_kondo` = TRUE, the wav file would be deleted.
#' # `overwrite` = TRUE would overwrite the wav file if previously existing.
#' }
player <- function(midifile,
                   soundfont = fluidsynth::soundfont_path(),
                   output = gsub(".mid$", ".mp3", midifile),
                   live = interactive(),
                   verbose = interactive(),
                   overwrite = TRUE,
                   marie_kondo = TRUE,
                   ...) {
  if (live) {
    fluidsynth::midi_play(
      midifile,
      soundfont,
      verbose = verbose,
      ...
    )
    return(invisible(NULL))
  }
  
  wavfile <- if (grepl(".mp3$", output)) gsub(".mp3$", ".wav", output) 
  outputs <- c(output, wavfile)
  outputs_exist <- file.exists(outputs)
  
  if (!overwrite & any(outputs_exist)) {
    stop("The following file(s)  exist(s):\n", paste(outputs[outputs_exist]), "\nUse `overwrite = TRUE` to overwrite it/them.")
  }
  
  wav_or_mp3 <- wavfile %||% output
  fluidsynth::midi_convert(
    midifile,
    soundfont,
    output = wav_or_mp3,
    verbose = verbose,
    ...
  )
  if (verbose) message("converted ", midifile, " to ", wav_or_mp3)
  
  if (!is.null(wavfile)) {
    av::av_audio_convert(wavfile, output, verbose = verbose)
    if (verbose) message("converted ", wavfile, " to ", output)
    if (marie_kondo) file.remove(wavfile)
    if (verbose) message("removed ", wavfile)
  }
  
  html_tag_audio(output, tools::file_ext(output))
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