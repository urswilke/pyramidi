test_that("applying miditapyr$nest_midi() and then miditapyr$unnest_midi() is roundtripping to the original dataframe", {
  # reticulate fails on travis
  # (error:
  # "Attributemodule 'miditapyr' has no attribute 'frame_midi'
  # but it should have)
  # skip_on_ci()
  skip_if_no_miditapyr()
  midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
  # mido <- reticulate::import("mido")
  # miditapyr <- reticulate::import("miditapyr")
  a <- mido$MidiFile(midi_file_string) %>% miditapyr$frame_midi() %>% miditapyr$unnest_midi()
  attr(a, "pandas.index") <- NULL
  b <- a %>% miditapyr$nest_midi() %>% miditapyr$unnest_midi()
  attr(b, "pandas.index") <- NULL
  expect_equal(a, b)
})
