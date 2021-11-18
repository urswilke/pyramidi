`%<-%` <- zeallot::`%<-%`

#' Construct a midi frame object
#'
#' Constructor of an object of class "r_midi_frames".
#'
#' @param midi_file_string Path to the midi file
#'
#' @return Midi frames S3 object
#' @export
#'
#' @examples
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' r_midi_frames(midi_file_string)
r_midi_frames <- function(midi_file_string) {
  mf <- miditapyr$MidiFrames(midi_file_string)

  dfm <- tab_measures(mf$midi_frame_unnested$df, ticks_per_beat = mf$midi_file$ticks_per_beat)

  # c(df_meta, df_not_notes, df_notes_wide) %<-% triage_measured_unnested(dfm)
  l <- triage_measured_unnested(dfm)
  df_meta <- l[[1]]
  df_not_notes <- l[[2]]
  df_notes_wide <- l[[3]]


  df_notes_long <- pivot_long_notes(df_notes_wide)

  df_long_mod <- merge_long_events(df_meta, df_notes_long, df_not_notes)

  structure(
    tibble::lst(
      mf,
      dfm,
      df_meta,
      df_not_notes,
      df_notes_wide,
      df_notes_long,
      df_long_mod
    ),
    class = c("r_midi_frames", "list")
  )
}


#' Modify notes in wide format and trigger updates of observers
#'
#' For a "r_midi_frames" object  \code{mfr}, this method replaces
#' mfr$mf$midi_frame_unnested$df, and all other
#' derived dataframes.
#'
#' @param mfr r_midi_frames object
#' @param mod Function modifying or dataframe replacing
#'
#' @return Updated r_midi_frames object.
#' @export
#'
#' @examples
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mfr <- r_midi_frames(midi_file_string)
#' # Function to replace every note with a random midi note between 60 & 71:
#' mod <- function(dfn) {
#'   n_notes <- sum(!is.na(dfn$note))
#'   dfn %>% dplyr::mutate(note = ifelse(
#'     !is.na(note),
#'     sample(60:71, n_notes, TRUE),
#'     note
#'   ))
#' }
#' # Apply the modification to mfr$df_notes_wide and all depending dataframes:
#' mfr <- mod_notes(mfr, mod)
#' # The data has also been changed in `mf` the miditapyr midi_frame object in mfr:
#' mfr$mf$midi_frame_nested$df
#'
#' # You can save the modified midi data back to a file:
#' mfr$mf$write_file("mod_test_midi_file.mid")
mod_notes <- function(mfr, mod) {
  UseMethod("mod_notes")
}
#' @export
mod_notes.r_midi_frames <- function(mfr, mod) {
  if (is.function(mod)) {
    mod <- mod(mfr$df_notes_wide)
  }

  mfr$df_notes_wide <- mod

  # recalculate the dataframes resulting from df_notes_wide in r_midi_frames:
  mfr$df_notes_long <- pivot_long_notes(mfr$df_notes_wide)

  mfr$df_long_mod <- merge_long_events(mfr$df_meta, mfr$df_notes_long, mfr$df_not_notes)

  mfr$mf$midi_frame_unnested$update_unnested_mf(mfr$df_long_mod)
  mfr
}



