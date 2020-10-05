#' Tabulate time signature
#'
#' @param df_meta
#'
#' @return
#' @export
#'
#' @examples
tab_time_sig <- function(df_meta) {
  df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(type =="time_signature") %>%
    dplyr::select(numerator, denominator, clocks_per_click, notated_32nd_notes_per_beat)
}

#' Get tempo
#'
#' @param df_meta
#'
#' @return
#' @export
#'
#' @examples
get_tempo <- function(df_meta) {
  df_meta %>%
    tibble::as_tibble() %>%
    dplyr::filter(type =="set_tempo") %>%
    dplyr::pull(tempo)
}
get_ticks2second_scale <- function(df_meta, ticks_per_beat) {
  get_tempo(df_meta) * 1e-6 / ticks_per_beat
}
get_bpm <- function(df_meta) {
  60 * 1e6 / get_tempo(df_meta)
}
