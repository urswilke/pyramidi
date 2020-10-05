#' write note_on and _off events in the same line (long to wide)
#'
#' @param df_measures
#'
#' @return
#' @export
#'
#' @examples
widen_events <- function(df_measures) {
  df_measures %>%
    dplyr::select(c("i_track", "name", "channel", "type", "m", "b", "t", "ticks", "time", "note", "velocity", "i_note")) %>%
    tidyr::pivot_wider(names_from = c("type"), values_from = c("m", "b", "t", "ticks", "time", "velocity")) %>%
    # as.data.frame() %>%
    dplyr::arrange(i_track, b_note_on)
}
