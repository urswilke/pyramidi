`%<-%` <- zeallot::`%<-%`

#' Construct a midi frame object
#'
#' Constructor of an object of class "midi_framer".
#'
#' @param midi_file_string Path to the midi file
#'
#' @return Midi frames S3 object
#' @export
#'
#' @examples
#' midi_file_string <- system.file("example_files", "Bass_sample.mid", package="tuneR")
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' new_midi_framer(midi_file_string)
new_midi_framer <- function(midi_file_string) {
  mf <- miditapyr$MidiFrames(midi_file_string)

  dfm <- tab_measures(mf$midi_frame_tidy$midi_frame_tidy, ticks_per_beat = mf$midi_file$ticks_per_beat)

  c(df_meta, df_not_notes, df_notes_wide) %<-% triage_measured_tidy(dfm)

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
    class = "midi_framer"
  )
}
