# reticulate::source_python("~/pyrmusic/python/py/py_funs.py")
# midi_defs <- get_midi_pitch_note_table() %>%
#   dplyr::select(-note)%>%
#   dplyr::select(note = pitch, note_name = nameWithOctave_unique) %>%
#   dplyr::mutate(note_name = forcats::as_factor(note_name)) %>%
#   tibble::as_tibble()
# usethis::use_data(midi_defs, overwrite = TRUE)


# note_name <- factor(c("C-1", "C#-1", "D-1", "Eb-1", "E-1", "F-1", "F#-1", "G-1", "G#-1", "A-1",
#                      "Bb-1", "B-1", "C0", "C#0", "D0", "Eb0", "E0", "F0", "F#0", "G0",
#                      "G#0", "A0", "Bb0", "B0", "C1", "C#1", "D1", "Eb1", "E1", "F1",
#                      "F#1", "G1", "G#1", "A1", "Bb1", "B1", "C2", "C#2", "D2", "Eb2",
#                      "E2", "F2", "F#2", "G2", "G#2", "A2", "Bb2", "B2", "C3", "C#3",
#                      "D3", "Eb3", "E3", "F3", "F#3", "G3", "G#3", "A3", "Bb3", "B3",
#                      "C4", "C#4", "D4", "Eb4", "E4", "F4", "F#4", "G4", "G#4", "A4",
#                      "Bb4", "B4", "C5", "C#5", "D5", "Eb5", "E5", "F5", "F#5", "G5",
#                      "G#5", "A5", "Bb5", "B5", "C6", "C#6", "D6", "Eb6", "E6", "F6",
#                      "F#6", "G6", "G#6", "A6", "Bb6", "B6", "C7", "C#7", "D7", "Eb7",
#                      "E7", "F7", "F#7", "G7", "G#7", "A7", "Bb7", "B7", "C8", "C#8",
#                      "D8", "Eb8", "E8", "F8", "F#8", "G8", "G#8", "A8", "Bb8", "B8",
#                      "C9", "C#9", "D9", "Eb9", "E9", "F9", "F#9", "G9"))
note <- 0:127
note_name <-
  c("C", "C#", "D", "Eb", "E", "F", "F#", "G", "G#", "A", "Bb", "B") %>%
  tidyr::expand_grid(-1:9, .) %>%
  dplyr::select(2, 1) %>%
  tidyr::unite("a", sep = "") %>%
  dplyr::slice(1:128) %>%
  dplyr::pull() %>%
  forcats::as_factor()

midi_defs <- tibble::tibble(note, note_name)
usethis::use_data(midi_defs, overwrite = TRUE)
