#' Write note_on and _off events in the same line (long to wide)
#'
#' @param df_measures data.frame resulting of miditapyr$mido_midi_df() and then running tab_measures() (see example)
#'
#' @return A data.frame with the following columns pivoted to wide: c("m", "b", "t", "ticks", "time", "velocity"). Every column is pivoted to wide with the suffix "_note_on" & "_note_off" showing the values of the original column as a prefix. See \code{?tab_measures} for an explanation of the meaning of these columns.
#'
#' @export
#'
#' @example man/rmdhunks/examples/generate_tidy_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' dfm %>% pivot_wide_notes()
#' }
pivot_wide_notes <- function(df_measures) {
  values_from_vector <-
  dplyr::intersect(
    names(df_measures),
    c("m", "b", "t", "ticks", "time", "velocity")
  )
  df_measures %>%
    # dplyr::select(c("i_track", "channel", "type", "m", "b", "t", "ticks", "time", "note", "velocity", "i_note")) %>%
    # dplyr::select(c("i_track", "name", "channel", "type", "m", "b", "t", "ticks", "time", "note", "velocity", "i_note")) %>%
    tidyr::pivot_wider(names_from = c("type"), values_from = !!values_from_vector) %>%
    # as.data.frame() %>%
    dplyr::arrange(.data$i_track, .data$b_note_on)
}





#' Write note_on and _off events in two lines (wide to long)
#'
#' @param df_notes_wide notes dataframe in wide format
#'
#' @return
#' @export
#'
#' @example man/rmdhunks/examples/generate_tidy_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' dfw <- dfm %>% pivot_wide_notes()
#'
#'
#' library(zeallot)
#' c(df_meta, df_notes) %<-% miditapyr$split_df(dfm)
#' }
pivot_long_notes <- function(df_notes_wide) {
  df_notes_wide %>%
    dplyr::select(
      c("i_track", "channel", "note", "i_note"),
      dplyr::matches("_note_o[nf]f?$")
    ) %>%
    tidyr::pivot_longer(
      dplyr::matches("_note_o[nf]f?$"),
      names_to = c(".value", "type"),
      names_pattern = "(.+?)_(.*)"
    ) %>%
    dplyr::mutate(meta = FALSE)



}


#' Merge dataframes transformed back to long format
#'
#' Merge dataframes transformed back to long format, remove added columns and
#' transform to the right chronological order in order to replace the original
#' midi_frame_tidy object.
#'
#' @param df_meta,df_notes_long,df_not_notes Results of `miditapyr$split_df()`.
#'
#' @return
#' @export
#'
#' @examples
#'
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mf <- miditapyr$MidiFrames(midi_file_string)
#'
#' dfm <- tab_measures(mf$midi_frame_tidy$midi_frame_tidy, ticks_per_beat = mf$midi_file$ticks_per_beat)
#'
#' l <- triage_measured_tidy(dfm)
#'
#' df_notes_long <- pivot_long_notes(l$df_notes_wide)
#'
#' merge_long_events(l$df_meta, df_notes_long, l$df_not_notes)
merge_long_events <- function(df_meta, df_notes_long, df_not_notes) {
  cols_to_remove <- c("i_note", "ticks", "t", "m", "b")

  df_notes_long %>%
    dplyr::full_join(df_meta) %>%
    dplyr::full_join(df_not_notes) %>%
    dplyr::arrange(i_track, ticks) %>%
    dplyr::group_by(i_track) %>%
    dplyr::mutate(time = ticks - dplyr::lag(ticks) %>% {.[1] = 0; .}) %>%
    dplyr::ungroup() %>%
    dplyr::select(-!!cols_to_remove)
}



#' Split tidy midi dataframe into parts
#'
#' Tidy midi frame from `\code{tab_measures()} is split into 3 parts:
#' df_meta, df_not_notes & df_notes_wide.
#'
#' @param dfm result of \code{tab_measures()}
#'
#' @return
#' @export
#'
#' @example man/rmdhunks/examples/generate_tidy_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' triage_measured_tidy(dfm)
#' }
triage_measured_tidy <- function(dfm) {
  c(df_meta, df_notes) %<-% miditapyr$split_df(dfm)

  df_not_notes <- df_notes %>%
    dplyr::filter(!stringr::str_detect(.data$type, "^note_o[nf]f?$"))

  df_notes_wide <- df_notes %>%
    dplyr::filter(stringr::str_detect(.data$type, "^note_o[nf]f?$")) %>%
    pivot_wide_notes()

  tibble::lst(df_meta, df_not_notes, df_notes_wide)
}


