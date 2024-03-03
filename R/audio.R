#' Play midi file
#' 
#' @description Play midi from MidiFramer object.
#' Helper function to synthesize midi, either:
#'   * directly in the console,
#'   * or generate audio files and include a small player in html documents.
#'   
#' This helper function is also called in the `MidiFramer$play()` method.
#' 
#' WARNING: Setting `overwrite = TRUE` (the default!!) will DELETE the specified audio files!!!
#' (see more details below)
#'
#' @param midifile Path to the midi file to synthesize on; character string.
#' @param soundfont path to sf2 sound font (character string); if not specified,
#'   the default soundfont of the fluidsynth package (`fluidsynth::soundfont_path()`) will be (downloaded if not present and) used.
#' @param output Path to the audiofile to be synthesized. (character string).
#' @param overwrite logical; defaults to TRUE;
#' if file exists and overwrite = FALSE, the existing files will not be overwritten and the function errors out.
#' @param verbose logical whether to print command line output; defaults to FALSE
#' @param live logical; if `TRUE` the synthesized midi is directly played in 
#'   the console. If `FALSE` an audio html tag is written. This will generate 
#'   a small audio player when knitting an Rmd document 
#'   (and probably also Quarto qmd files; I didn't check).
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
#' mp3file <- "test.mp3"
#' fluidsynth::midi_convert(midifile, output = mp3file)
#' # `overwrite` = TRUE overwrites the mp3 file if previously existing.
#' }
player <- function(midifile,
                   soundfont = fluidsynth::soundfont_path(),
                   output = gsub(".mid$", ".mp3", midifile),
                   live = interactive(),
                   verbose = interactive(),
                   overwrite = TRUE,
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

  if (!overwrite & file.exists(output)) {
    stop("The file\n", output, "exists:\nUse `overwrite = TRUE` to overwrite it/them.")
  }
  
  fluidsynth::midi_convert(
    midifile,
    soundfont,
    output = output,
    verbose = verbose,
    ...
  )
  if (verbose) message("converted ", midifile, " to ", output)

  html_tag_audio(output)
}

# from here: https://community.rstudio.com/t/audio-files-in-r-markdown/20874/3
html_tag_audio <- function(file) {
  type <- tools::file_ext(file)
  htmltools::tags$audio(
    controls = "",
    htmltools::tags$source(
      src = file,
      type = glue::glue("audio/{type}", type = type)
    )
  )
}