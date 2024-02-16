#' MidiFramer class
#'
#' \itemize{
#'   \item{See the \code{vignette("pyramidi")} for a brief usage introduction how to manipulate midi data.}
#'   \item{The \code{vignette("compose")} shows a more extended example how to generate midi files from scratch.}
#'   \item{\code{vignette("package_workflow")} shows in detail the structure of the \code{MidiFramer} class.}
#'   \item{\code{vignette("functions_usage")} illustrates the low-level functions of the pyramidi package.
#'   that \code{MidiFramer} objects use under the hood.}
#' }
#'
#' @description The class \code{MidiFramer} can be used to read midi files to
#' dataframes in order to facilitate to manipulate the data from R. You can also
#' create midi data from R without reading it from a file.
#' The data is transformed to various formats.
#' One of the \code{MidiFramer} fields is a
#' \href{https://miditapyr.readthedocs.io/en/latest/miditapyr.html#miditapyr.midi_frame.MidiFrames}{\code{MidiFrames}}
#' object of the python miditapyr package. Its method
#' \href{https://miditapyr.readthedocs.io/en/latest/miditapyr.html#miditapyr.midi_frame.MidiFrames.write_file}{write_file()}
#' can be used to write the data back to a midi file.
#'
#' @field midi_file_string Path to the midi file.
#' @field mf \href{https://miditapyr.readthedocs.io/en/latest/miditapyr.html#miditapyr.midi_frame.MidiFrames}{\code{miditapyr$MidiFrames}} object.
#' @field dfm result of \code{tab_measures()}.
#' @field df_notes_long Result of \code{pivot_long_notes()}.
#' @field df_meta,df_not_notes,df_notes_wide Results of \code{split_midi_frame()}.
#' @field midi_frame_mod Result of \code{merge_midi_frames()}.
#' @field params Parameters used in internal functions; Named list; params$columns_to_add is passed to \code{tab_measures(columns_to_add)}.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ## Create a MidiFramer object from a midi file:
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' MidiFramer$new(midi_file_string)
#'
#' ## ------------------------------------------------
#' ## Create empty MidiFramer object to illustrate
#' ## the use of the `ticks_per_beat` active binding:
#' ## ------------------------------------------------
#'
#' mfr <- MidiFramer$new()
#' # Print default value of empty MidiFile object:
#' mfr$mf$midi_file$ticks_per_beat
#' # Modify it with the active binding ticks_per_beat:
#' mfr$ticks_per_beat <- 960L
#' # Print it again:
#' mfr$mf$midi_file$ticks_per_beat
#' }
MidiFramer <- R6::R6Class(
  "MidiFramer",
  public = list(
    midi_file_string = NULL,
    mf = NULL,
    dfm = NULL,
    df_notes_long = NULL,
    df_meta = NULL,
    df_not_notes = NULL,
    df_notes_wide = NULL,
    midi_frame_mod = NULL,
    params = list(
      columns_to_add = "b"
    ),

    #' @description Initialize a MidiFramer object
    #'
    #' @param midi_file_string Path to the midi file; if NULL (the default), an empty \code{MidiFramer} object is created.
    initialize = function(midi_file_string = NULL) {
      self$midi_file_string <- midi_file_string

      self$mf <- miditapyr$MidiFrames(self$midi_file_string)

      self$populate_r_fields()
    },

    #' @description Update a MidiFramer object with modified notes
    #'
    #' @param mod Dataframe or function returning a dataframe of the format of \code{df_notes_wide}.
    #' @examples
    #' \dontrun{
    #' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
    #' mfr <- MidiFramer$new(midi_file_string)
    #' # Function to replace every note with a random midi note between 60 & 71:
    #' mod <- function(dfn) {
    #'   n_notes <- sum(!is.na(dfn$note))
    #'   dfn %>% dplyr::mutate(note = ifelse(
    #'     !is.na(note),
    #'     sample(60:71, n_notes, TRUE),
    #'     note
    #'   ))
    #' }
    #' set.seed(123)
    #' mfr$update_notes_wide(mod)
    #' mfr$play()
    #' # You can pass functions to the $update_notes_wide() method (as above), but
    #' # you can also modify the dataframe directly and pass it. Therefore, the
    #' # following results in the same:
    #' set.seed(123)
    #' df_mod <- mod(mfr$df_notes_wide)
    #' mfr$update_notes_wide(df_mod)
    #' mfr$play()
    #' }
    update_notes_wide = function(mod) {
      mod_notes.r_midi_frames(self, mod)
      invisible(self)
    },
    #' @description Populate the fields of a MidiFramer object
    #'
    #' This can also be used to recalculate all the object's attributes,
    #' when a value in params is changed (see examples).
    #'
    #' @examples
    #' \dontrun{
    #' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
    #' mfr <- MidiFramer$new(midi_file_string)
    #' mfr$params$columns_to_add <- c("m", "b", "t", "time")
    #' mfr$populate_r_fields()
    #' }
    populate_r_fields = function() {


      if (!is.null(self$mf$`_midi_frame_raw`)) {
        self$dfm <- tab_measures(
          self$mf$midi_frame_unnested$df,
          ticks_per_beat = self$mf$midi_file$ticks_per_beat,
          columns_to_add = self$params$columns_to_add
        )
      }
      else {
        self$dfm <- NULL
      }

      c(self$df_meta, self$df_not_notes, self$df_notes_wide) %<-% split_midi_frame(self$dfm)

      self$df_notes_long <- pivot_long_notes(self$df_notes_wide)

      self$midi_frame_mod <- merge_midi_frames(self$df_meta, self$df_notes_long, self$df_not_notes)
      invisible(self)
    },
    #' @description Play midi from MidiFramer object.
    #' Transform the midi file to fileext format and provide a play button for html
    #' documents.
    #' 
    #' WARNING: Setting `overwrite = TRUE` or `marie_kondo = TRUE` (the default!!) will DELETE the specified audio files!!! 
    #' (see more details below)
    #' 
    #' @param audiofile Path to the audiofile to be synthesized. If audiofile of type mp3, it will
    #' first be synthesized to wav, and then converted to mp3 with ffmpeg;
    #' (character string).
    #' @param soundfont path to sf2 sound font (character string); if not specified,
    #'   the default soundfont of the fluidsynth package (`fluidsynth::soundfont_path()`) will be (downloaded if not present and) used.
    #' @param midifile Path to the midi file to synthesize on. If `marie_kondo = TRUE`, it will be cleaned up (removed) at the end;
    #' (character string).
    #' @param overwrite logical; defaults to TRUE;
    #' if file exists and overwrite = FALSE, the existing files will not be overwritten and the function errors out.
    #' @param verbose logical whether to print command line output; defaults to FALSE
    #' @param live logical; if `TRUE` the synthesized midi is directly played in 
    #'   the console. If `FALSE` an audio html tag is written. This will generate 
    #'   a small audio player when knitting an Rmd document 
    #'   (and probably also Quarto qmd files; I didn't check).
    #' @param marie_kondo logical, whether to remove intermediate files (the midi
    #'   file, and if live = `FALSE` and `audiofile` is an mp3 also it also 
    #'   deletes the intermediate wav file); defaults to `TRUE`
    #' @param ... Arguments passed to the fluidsynth functions 
    #'   (`fluidsynth::midi_play` or `fluidsynth::midi_convert` 
    #'   depending on the value of `live`).
    #' @examples
    #' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
    #' mfr <- MidiFramer$new(midi_file_string)
    #' mfr$play()
    #' # The play method does basically this:
    #' \dontrun{
    #' midi_out <- "my_output.mid"
    #' audiofile <- "test.wav"
    #' mp3file <- "test.mp3"
    #' mfr$mf$write_file(midi_out)
    #' fluidsynth::midi_convert(midifile, output = audiofile)
    #' av::av_audio_convert(audiofile, mp3file)
    #' # `marie_kondo` = TRUE, the midi (and wav if `audiofile` is an mp3 file) file would be deleted.
    #' # `overwrite` = TRUE overwrites midi_out, audiofile & mp3file
    #' }
    play = function(
      audiofile = tempfile("mf_out_", fileext = ".mp3"),
      soundfont = fluidsynth::soundfont_path(),
      midifile = gsub(".mp3$", ".mid", audiofile),
      live = interactive(),
      verbose = FALSE,
      overwrite = TRUE,
      marie_kondo = TRUE,
      ...
    ) {
      if (!overwrite & file.exists(midifile)) {
        stop("The following file  exists:\n", midifile, "\nUse `overwrite = TRUE` to overwrite it.")
      }
      if (marie_kondo) {
        on.exit(unlink(midifile))
      }
      self$mf$write_file(midifile)
      player(
        midifile,
        soundfont,
        audiofile,
        live,
        verbose,
        overwrite,
        marie_kondo,
        ...
      )
    }
  ),
  private = list(
    # for doing deep copies, we also need to deepcopy the python object.
    # See here, for the inspiration of this code:
    # https://jangorecki.gitlab.io/data.cube/library/R6/doc/Introduction.html#cloning-objects
    deep_clone = function(name, value) {
      # With x$clone(deep=TRUE) is called, the deep_clone gets invoked once for
      # each field, with the name and value.
      if (name == "mf") {
        # We are doing a deep copy with the python copy module:
        copy$deepcopy(value)
      } else {
        # For all other fields, just return the value
        value
      }
    }
  ),
  active = list(
    #' @field ticks_per_beat
    #' Set ticks per beat of \code{MidiFrames()$mf$midi_file}.
    #' The value of \code{ticks_per_beat} passed should be integer.
    #' When a value is passed, the field \code{mf$midi_file$ticks_per_beat} is modified.
    ticks_per_beat = function(value) {
      if (missing(value)) return(self$mf$midi_file$ticks_per_beat)
      if (!is.numeric(value)) {
        stop("`ticks_per_beat` needs to be specified as an integer.")
      }
      if (!is.integer(value)) {
        value = as.integer(value)
        warning("`ticks_per_beat` was transformed to integer.")
      }
      reticulate::py_set_attr(self$mf$midi_file, "ticks_per_beat", value)
    }
  )
)

## Would love to do that, but doesn't work...:
# see here for inspiration: https://stackoverflow.com/a/54544769
# MidiFramer$set("public", "clone", function(deep = TRUE, verbose = TRUE) {
#   if (verbose) {
#     message("By default deep cloning; turn off this notification by setting: verbose = FALSE.")
#   }
#   self$clone(deep = deep)
# })
