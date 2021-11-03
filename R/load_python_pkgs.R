# global reference to miditapyr (will be initialized in .onLoad)
#' Miditapyr python module
#'
#' @return reticulate python module
#' @export
#' @examples
#' miditapyr$mido_io$midi_to_df
miditapyr <- NULL

# global reference to mido (will be initialized in .onLoad)
#' Mido python module
#'
#' @return reticulate python module
#' @export
#' @examples
#' mido$MidiFile
mido <- NULL

.onLoad <- function(libname, pkgname) {
  # found in https://github.com/kevinushey/usespandas/blob/master/R/zzz.R
  reticulate::configure_environment(pkgname, force = TRUE)
  # use superassignment to update global reference to miditapyr
  miditapyr <<- reticulate::import("miditapyr", delay_load = TRUE)
  # use superassignment to update global reference to mido
  mido <<- reticulate::import("mido", delay_load = TRUE)
}
