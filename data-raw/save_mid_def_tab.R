reticulate::source_python("~/pyrmusic/python/py/py_funs.py")
midi_defs <- get_midi_pitch_note_table() %>%
  dplyr::select(-note)%>%
  dplyr::select(note = pitch, note_name = nameWithOctave_unique) %>%
  dplyr::mutate(note_name = forcats::as_factor(note_name)) %>%
  tibble::as_tibble()
usethis::use_data(midi_defs, overwrite = TRUE)
