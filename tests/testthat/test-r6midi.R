midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
mfr6 <- MidiFramer$new(midi_file_string)

test_that("MidiFramer seems to work", {
  expect_snapshot(c("df_long_mod", "df_notes_wide", "df_not_notes",
                    "df_meta", "df_notes_long", "dfm", "mf", "midi_file_string") %>% purrr::set_names() %>% purrr::map(~`[[`(mfr6, .x)))
  expect_snapshot(list(
    mfr6$mf$midi_frame_raw,
    mfr6$mf$midi_frame_unnested$df,
    mfr6$mf$midi_frame_nested$df
  ) %>%
    purrr::map(head, 20))
})
