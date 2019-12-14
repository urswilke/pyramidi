reticulate::source_python("~/pyrmusic/python/py/py_funs.py")
midi_defs <- get_midi_pitch_note_table() %>% dplyr::select(-note)
usethis::use_data(midi_defs)
