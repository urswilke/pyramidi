if (!testthat:::on_ci()) {
  reticulate::use_python("/home/chief/anaconda3/bin/python", required = TRUE)
}


skip_if_no_miditapyr <- function() {
  have_miditapyr <- reticulate::py_module_available("miditapyr")
  if (!have_miditapyr)
    skip("miditapyr not available for testing")
}

test_that("applying miditapyr$compact_df() and then miditapyr$tidy_df() is roundtripping to the original dataframe", {
  # reticulate fails on travis
  # (error:
  # "Attributemodule 'miditapyr' has no attribute 'midi_to_df'
  # but it should have)
  # skip_on_ci()
  skip_if_no_miditapyr()
  content <- system.file("example_files", "Bass_sample.mid", package="tuneR")
  # mido <- reticulate::import("mido")
  # miditapyr <- reticulate::import("miditapyr")
  a <- mido$MidiFile(content) %>% miditapyr$midi_to_df() %>% miditapyr$tidy_df()
  attr(a, "pandas.index") <- NULL
  b <- a %>% miditapyr$compact_df() %>% miditapyr$tidy_df()
  attr(b, "pandas.index") <- NULL
  expect_equal(a, b)
})
