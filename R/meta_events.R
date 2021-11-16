#' Tabulate time signature
#'
#' @param df_meta data.frame containing midi meta event data resulting of miditapyr$split_df()
#'
#' @return time signature data.frame
#' @importFrom rlang .data
#'
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' miditapyr$split_df(dfm)  %->% c(df_meta, df_notes)
#' pyramidi:::tab_time_sig(df_meta)
#' }
tab_time_sig <- function(df_meta) {
  df_time_sig <-
    df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(.data$type =="time_signature")
  if (nrow(df_time_sig) > 0) {
    return(df_time_sig %>%
             dplyr::select(.data$numerator, .data$denominator, .data$clocks_per_click, .data$notated_32nd_notes_per_beat))
  }
  else {
    return(
      tibble::tibble(
        numerator = 4,
        denominator = 4,
        clocks_per_click = 24,
        notated_32nd_notes_per_beat = 8
      )
    )
  }
}

#' Get tempo
#'
#' @param df_meta data.frame containing midi meta event data resulting of miditapyr$split_df()
#'
#' @export
#' @return tempo integer
#'
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' miditapyr$split_df(dfm)  %->% c(df_meta, df_notes)
#' get_tempo(df_meta)
#' }
get_tempo <- function(df_meta) {
  df_tempo <- df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(.data$type =="set_tempo")
  if (nrow(df_tempo > 0)) {
    return(
      df_tempo %>%
        dplyr::pull(.data$tempo)
    )
  }
  else {
    # https://mido.readthedocs.io/en/latest/midi_files.html#midi-tempo-vs-bpm
    return(500000L)
  }
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
#' @example man/rmdhunks/examples/generate_unnested_df.Rmd
#' @examples
#' \dontrun{
#' dfm <- tab_measures(df, ticks_per_beat)
#' library(zeallot)
#' miditapyr$split_df(dfm)  %->% c(df_meta, df_notes)
#' get_bpm(df_meta)
#' }
get_bpm <- function(df_meta) {
  60 * 1e6 / get_tempo(df_meta)
}
