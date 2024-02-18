midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
mfr6 <- MidiFramer$new(midi_file_string)

mfr <- MidiFramer$new()

test_that("MidiFramer seems to work", {
  expect_snapshot(c("midi_frame_mod", "df_notes_wide", "df_not_notes",
                    "df_meta", "df_notes_long", "dfm", "mf") %>% purrr::set_names() %>% purrr::map(~`[[`(mfr6, .x)),
                  transform = \(x) stringr::str_replace(x, "0x[0-9a-fA-F]+", "<stochastic term :)>"))
  expect_snapshot(list(
    mfr6$mf$midi_frame_raw,
    mfr6$mf$midi_frame_unnested$df,
    mfr6$mf$midi_frame_nested$df
  ) %>%
    purrr::map(head, 20))

})

test_that("MidiFramer$update_notes_wide() seems to work", {
  df_meta <- mfr6$df_meta[1:4,]
  df_notes_wide <- mfr6$df_notes_wide[1:2,]

  mfr6$df_meta <- df_meta
  mfr6$update_notes_wide(df_notes_wide)

  expect_snapshot(mfr6$mf$midi_frame_nested$df)
})

test_that("Changing params and recalculating works.", {
  mfr6$params$columns_to_add <- c("m", "b", "t", "time")
  mfr6$populate_r_fields()
  expect_snapshot(mfr6$df_notes_wide)
})




test_that("empty MidiFramer seems to work", {
  mfr_attrs <- c("midi_frame_mod", "df_notes_wide", "df_not_notes",
    "df_meta", "df_notes_long", "dfm") %>%
    purrr::set_names() %>%
    purrr::map(~`[[`(mfr, .x))
  mfr_attrs %>% purrr::map(expect_null)

  expect_error(mfr$mf$midi_frame_raw)
  expect_error(mfr$mf$midi_frame_unnested$df)
  expect_error(mfr$mf$midi_frame_nested$df)
})


test_that("active field `ticks_per_beat` works", {
  expect_error(mfr$ticks_per_beat <- "a")
  expect_warning(mfr$ticks_per_beat <- 1.5)
  expect_equal(mfr$mf$midi_file$ticks_per_beat, 1)
  expect_equal(mfr$ticks_per_beat, 1)
})

