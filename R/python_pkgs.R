# global reference to miditapyr (will be initialized in .onLoad)
#' Miditapyr python module
#'
#' @return reticulate python module
#' @export
#' @examples
#' \dontrun{
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' miditapyr$MidiFile(midi_file_string)
#' }
miditapyr <- NULL

# global reference to mido (will be initialized in .onLoad)
#' Mido python module
#'
#' @return reticulate python module
#' @export
#' @examples
#' \dontrun{
#' midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
#' mido$MidiFile(midi_file_string)
#' }
mido <- NULL

.onLoad <- function(libname, pkgname) {
  # # found in https://github.com/kevinushey/usespandas/blob/master/R/zzz.R
  reticulate::configure_environment(pkgname, force = TRUE)
  # use superassignment to update global reference to miditapyr
  miditapyr <<- reticulate::import("miditapyr", delay_load = TRUE)
  # use superassignment to update global reference to mido
  mido <<- reticulate::import("mido", delay_load = TRUE)
}


#' Install miditapyr python package
#'
#' Wrapper around `reticulate::py_install()` to install the miditapyr python package
#'
#' @param envname The name, or full path, of the environment in which python
#'  packages are to be installed. When `NULL` (default), the active environment
#'  (`RETICULATE_PYTHON_ENV` variable) will be used; if that is unset, then the
#'  `"r-reticulate"` environment will be used.
#' @param method Installation method. By default, "auto" automatically finds a
#'   method that will work in the local environment. Change the default to force
#'   a specific installation method. Note that the "virtualenv" method is not
#'   available on Windows.
#' @param conda The path to a conda executable. Use "auto" to allow reticulate
#'   to automatically find an appropriate conda binary. See Finding Conda for
#'   more details.
#' @param pip Boolean; use pip for package installation? This is only relevant
#'   when Conda environments are used, as otherwise packages will be installed
#'   from the Conda repositories.
#' @details From `reticulate::py_install()`: On Linux and OS X the "virtualenv"
#'   method will be used by default ("conda" will be used if virtualenv isn't
#'   available). On Windows, the "conda" method is always used.
#'
#' @export
#'
install_miditapyr <- function(
  envname = NULL,
  method = "auto",
  conda = "auto",
  pip = TRUE
) {
  # try to install miditapyr
  reticulate::py_install(
    "miditapyr",
    envname = envname,
    method = method,
    conda = conda,
    pip = pip
  )
}
