midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
mfr <- r_midi_frames(midi_file_string)

test_that("print of r_midi_frames() correct", {
  expect_snapshot(mfr)
  expect_snapshot(list(
    mfr$mf$midi_frame_raw,
    mfr$mf$midi_frame_tidy$midi_frame_tidy,
    mfr$mf$midi_frame_compact$midi_frame_compact
  ))
})
