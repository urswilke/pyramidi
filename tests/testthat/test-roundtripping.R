test_that("applying miditapyr$compact_df() and then miditapyr$tidy_df() is roundtripping to the original dataframe", {
  # reticulate fails on travis
  # (error:
  # "Attributemodule 'miditapyr' has no attribute 'midi_to_df'
  # but it should have)
  # skip_on_ci()
  skip_if_no_miditapyr()
  midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
  # mido <- reticulate::import("mido")
  # miditapyr <- reticulate::import("miditapyr")
  a <- mido$MidiFile(midi_file_string) %>% miditapyr$midi_to_df() %>% miditapyr$tidy_df()
  attr(a, "pandas.index") <- NULL
  b <- a %>% miditapyr$compact_df() %>% miditapyr$tidy_df()
  attr(b, "pandas.index") <- NULL
  expect_equal(a, b)
})
