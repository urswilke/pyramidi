test_that("applying mt$compact_df() and then mt$tidy_df() is roundtripping to the original dataframe", {
  # reticulate fails on travis
  # (error:
  # "Attributemodule 'miditapyr' has no attribute 'midi_to_df'
  # but it should have)
  # skip_on_ci()
  content <- system.file("example_files", "Bass_sample.mid", package="tuneR")
  mido <- reticulate::import("mido")
  mt <- reticulate::import("miditapyr")
  a <- mido$MidiFile(content) %>% mt$midi_to_df() %>% mt$tidy_df()
  attr(a, "pandas.index") <- NULL
  b <- a %>% mt$compact_df() %>% mt$tidy_df()
  attr(b, "pandas.index") <- NULL
  expect_equal(a, b)
})
