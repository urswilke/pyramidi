#' Construct a midi frame R6 object
#'
#' Constructor of an object of class "MidiFramer".
#'
#' @field midi_file_string Path to the midi file
#' @field mf miditapyr$MidiFrames object,
#' @field dfm result of \code{tab_measures()}
#' @field df_notes_long result of \code{pivot_long_notes()}
#' @field df_meta,df_not_notes,df_notes_wide results of \code{triage_measured_unnested()}
#' @field df_long_mod result of \code{merge_long_events()}
#'
#' @return MidiFramer R6 object
#' @export
#'
#' @examples
#' \dontrun{
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' MidiFramer$new(midi_file_string)
#'
#' # Create empty MidiFramer object:
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
    df_long_mod = NULL,

    #' @description Initialize a MidiFramer object
    #'
    #' @param midi_file_string Path to the midi file
    initialize = function(midi_file_string = NULL) {
      self$midi_file_string <- midi_file_string

      self$mf <- miditapyr$MidiFrames(midi_file_string)

      if (!is.null(self$mf$`_midi_frame_raw`)) {
        self$dfm <- tab_measures(self$mf$midi_frame_unnested$df, ticks_per_beat = self$mf$midi_file$ticks_per_beat)
      }
      else {
        self$dfm <- NULL
      }

      c(self$df_meta, self$df_not_notes, self$df_notes_wide) %<-% triage_measured_unnested(self$dfm)

      self$df_notes_long <- pivot_long_notes(self$df_notes_wide)

      self$df_long_mod <- merge_long_events(self$df_meta, self$df_notes_long, self$df_not_notes)
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
    #' @description Play midi from MidiFramer object
    #' Transform the midi file to fileext format and provide a play button for html
    #' documents.
    #'
    #' @param audiofile Path to the audiofile to be synthesized
    #' @param overwrite logical; defaults to FALSE;
    #' if file exists and overwrite = FALSE, the existing files will be used and nothing
    #' is synthesized/converted to audio files.
    #'
    #' @examples
    #' \dontrun{
    #' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
    #' mfr <- MidiFramer$new(midi_file_string)
    #' mfr$play()
    #' }
    play = function(
      audiofile = tempfile("mf_out_", fileext = ".wav"),
      overwrite = FALSE
    ) {
      play_midi_frame(
        self,
        audiofile = audiofile,
        overwrite = overwrite
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
    #' Set ticks per beat of \copy{MidiFrames()$mf$midi_file}.
    #' The value of ticks_per_beat passed should be integer.
    #' When a value is passed, the field \code{mf$midi_file field$ticks_per_beat} is modified.
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
