#' Tabulate time signature
#'
#' @param df_meta data.frame containing midi meta event data resulting of miditapyr$split_df()
#'
#' @return time signature data.frame
#' @importFrom rlang .data
#'
#' @example man/rmdhunks/examples/generate_tidy_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' mt$split_df(dfm)  %->% c(df_meta, df_notes)
#' pyramidi:::tab_time_sig(df_meta)
#' }
tab_time_sig <- function(df_meta) {
  df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(.data$type =="time_signature") %>%
    dplyr::select(.data$numerator, .data$denominator, .data$clocks_per_click, .data$notated_32nd_notes_per_beat)
}

#' Get tempo
#'
#' @param df_meta data.frame containing midi meta event data resulting of miditapyr$split_df()
#'
#' @export
#' @return tempo integer
#'
#' @example man/rmdhunks/examples/generate_tidy_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' mt$split_df(dfm)  %->% c(df_meta, df_notes)
#' get_tempo(df_meta)
#' }
get_tempo <- function(df_meta) {
  df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(.data$type =="set_tempo") %>%
    dplyr::pull(.data$tempo)
}
get_ticks2second_scale <- function(df_meta, ticks_per_beat) {
  get_tempo(df_meta) * 1e-6 / ticks_per_beat
}
#' Get beats per minute
#'
#' @param df_meta  data.frame containing midi meta event data resulting of miditapyr$split_df()
#'
#' @return integer of beats per minute
#' @export
#'
#' @example man/rmdhunks/examples/generate_tidy_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' mt$split_df(dfm)  %->% c(df_meta, df_notes)
#' get_bpm(df_meta)
#' }
get_bpm <- function(df_meta) {
  60 * 1e6 / get_tempo(df_meta)
}
