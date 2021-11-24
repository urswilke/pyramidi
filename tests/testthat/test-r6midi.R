midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
mfr6 <- MidiFramer$new(midi_file_string)

test_that("MidiFramer seems to work", {
  expect_snapshot(c("midi_frame_mod", "df_notes_wide", "df_not_notes",
                    "df_meta", "df_notes_long", "dfm", "mf") %>% purrr::set_names() %>% purrr::map(~`[[`(mfr6, .x)))
  expect_snapshot(list(
    mfr6$mf$midi_frame_raw,
    mfr6$mf$midi_frame_unnested$df,
    mfr6$mf$midi_frame_nested$df
  ) %>%
    purrr::map(head, 20))
})

test_that("empty MidiFramer seems to work", {
  mfr <- MidiFramer$new()
  mfr_attrs <- c("midi_frame_mod", "df_notes_wide", "df_not_notes",
    "df_meta", "df_notes_long", "dfm") %>%
    purrr::set_names() %>%
    purrr::map(~`[[`(mfr, .x))
  mfr_attrs %>% purrr::map(expect_null)

  expect_error(mfr$mf$midi_frame_raw)
  expect_error(mfr$mf$midi_frame_unnested$df)
  expect_error(mfr$mf$midi_frame_nested$df)
})
