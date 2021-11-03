
test_that("meta events work", {
  skip_if_no_miditapyr()
  mid_file_str <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
  mido_mid_file <- mido$MidiFile(mid_file_str)
  dfc <- miditapyr$midi_to_df(mido_mid_file)
  ticks_per_beat = mido_mid_file$ticks_per_beat
  df <- dfc %>%
    miditapyr$tidy_df()
  miditapyr$split_df(df)  %->% c(df_meta, df_notes)

  dfm <- tab_measures(df, ticks_per_beat)
  dfw <- dfm %>% widen_events()
  testthat::expect_snapshot(tab_time_sig(df_meta))
  testthat::expect_snapshot(dfm)
  testthat::expect_snapshot(dfw)
  expect_equal(get_tempo(df_meta), 666666)
  expect_equal(round(get_bpm(df_meta), 2), 90)
})
