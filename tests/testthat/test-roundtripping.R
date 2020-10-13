test_that("applying mt$compact_df() and then mt$tidy_df() is roundtripping to the original dataframe", {
  content <- system.file("example_files", "Bass_sample.mid", package="tuneR")
  mido <- reticulate::import("mido")
  mt <- reticulate::import("miditapyr")
  a <- mido$MidiFile(content) %>% mt$midi_to_df() %>% mt$tidy_df()
  b <- a %>% mt$compact_df() %>% mt$tidy_df()
  expect_equal(a, b)
})
