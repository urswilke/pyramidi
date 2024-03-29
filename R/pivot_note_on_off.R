#' Write \code{note_on} and \code{note_off} events in the same line (long to wide)
#'
#' @param df_measures data.frame resulting of miditapyr$mido_midi_df() and then running tab_measures() (see example)
#'
#' @return A data.frame with the following columns pivoted to wide: c("m", "b", "t", "ticks", "time", "velocity"). Every column is pivoted to wide with the suffix "_note_on" & "_note_off" showing the values of the original column as a prefix. See \code{?tab_measures} for an explanation of the meaning of these columns.
#' @family Pivot midi frame functions
#'
#' @export
#'
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' c(df_meta, df_notes) %<-% miditapyr$split_df(dfm)
#' df_notes %>% pivot_wide_notes()
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
    dplyr::arrange(i_track, b_note_on)
}





#' Write \code{note_on} and \code{note_off} events in two lines (wide to long)
#'
#' @param df_notes_wide notes dataframe in wide format
#'
#' @return Transforms notes in wide dataframe format to long format.
#' @family Pivot midi frame functions
#' @export
#'
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' c(df_meta, df_notes) %<-% miditapyr$split_df(dfm)
#' dfw <- df_notes %>% pivot_wide_notes()
#' dfw %>% pivot_long_notes()
#' }
pivot_long_notes <- function(df_notes_wide) {
  if (is.null(df_notes_wide)) {
    return(NULL)
  }
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
#' midi_frame_unnested object.
#'
#' @param df_meta,df_notes_long,df_not_notes Dataframes in the format of \code{split_midi_frame()}.
#'
#' @return Merges the input dataframes, arranges by \code{i_track} & (absolute) \code{ticks}, and
#'   calculates \code{time} (in relative ticks since the last event).
#' @export
#' @family Split/merge meta/notes/non-note events
#'
#' @examples
#' \dontrun{
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mf <- miditapyr$MidiFrames(midi_file_string)
#'
#' dfm <- tab_measures(mf$midi_frame_unnested$df, ticks_per_beat = mf$midi_file$ticks_per_beat)
#'
#' l <- split_midi_frame(dfm)
#'
#' df_notes_long <- pivot_long_notes(l$df_notes_wide)
#'
#' merge_midi_frames(l$df_meta, df_notes_long, l$df_not_notes)
#' }
merge_midi_frames <- function(df_meta, df_notes_long, df_not_notes) {
  if (is.null(df_meta) & is.null(df_notes_long) & is.null(df_not_notes)) {
    return(NULL)
  }
  cols_to_remove <- c("i_note", "ticks", "t", "m", "b")

  res <- df_notes_long %>%
    dplyr::bind_rows(df_meta) %>%
    dplyr::bind_rows(df_not_notes)

  # if in tab_measures() there weren't all columns built, we have to remove them here:
  cols_to_remove <- intersect(cols_to_remove, names(res))
  res %>%
    dplyr::arrange(i_track, ticks) %>%
    dplyr::group_by(i_track) %>%
    dplyr::mutate(time = ticks - dplyr::lag(ticks) %>% {.[1] = 0; .}) %>%
    dplyr::ungroup() %>%
    dplyr::select(-!!cols_to_remove)
}



#' Split unnested midi dataframe into parts
#'
#' Unnested midi frame with time data from \code{tab_measures()} is split into 3 parts:
#' \itemize{
#'   \item{df_meta: Consisting of all the \href{https://mido.readthedocs.io/en/latest/midi_files.html#meta-messages}{meta} events in the midi data.}
#'   \item{df_not_notes: Containing all midi events that are not \code{meta} and not \code{note_on} or \code{note_off}.}
#'   \item{df_notes_wide: All \code{note_on} or \code{note_off} events and furthermore transformed to wide format by \code{pivot_note_wide}.}
#' }
#'
#' @param dfm result of \code{tab_measures()}
#'
#' @return df_meta, df_not_notes & df_notes_wide
#' @export
#' @family Split/merge meta/notes/non-note events
#'
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' split_midi_frame(dfm)
#' }
split_midi_frame <- function(dfm) {
  if (is.null(dfm)) {
    return(list(NULL, NULL, NULL))
  }
  # c(df_meta, df_notes) %<-% miditapyr$split_df(dfm)
  l <- miditapyr$split_df(dfm)
  df_meta <- l[[1]]
  df_notes <- l[[2]]

  df_not_notes <- df_notes %>%
    dplyr::filter(!stringr::str_detect(type, "^note_o[nf]f?$"))

  df_notes_wide <- df_notes %>%
    dplyr::filter(stringr::str_detect(type, "^note_o[nf]f?$")) %>%
    pivot_wide_notes()

  tibble::lst(df_meta, df_not_notes, df_notes_wide)
}


