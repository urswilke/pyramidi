# global reference to scipy (will be initialized in .onLoad)
#' @export
miditapyr <- NULL

# global reference to scipy (will be initialized in .onLoad)
#' @export
mido <- NULL

.onLoad <- function(libname, pkgname) {
  # found in https://github.com/kevinushey/usespandas/blob/master/R/zzz.R
  reticulate::configure_environment(pkgname, force = TRUE)
  # use superassignment to update global reference to miditapyr
  miditapyr <<- reticulate::import("miditapyr", delay_load = TRUE)
  # use superassignment to update global reference to mido
  mido <<- reticulate::import("mido", delay_load = TRUE)
}
