# Using reticulate in an R Package
# See:
# https://rstudio.github.io/reticulate/articles/package.html

mido <- NULL
miditapyr <- NULL
# reticulate::use_python('/home/chief/anaconda3/bin/python3.7')

.onLoad <- function(libname, pkgname) {
  # use superassignment to update global reference to mido & miditapyr
  # miditapyr <<- reticulate::import("miditapyr", delay_load = TRUE)

  mido <<- reticulate::import("mido", delay_load = TRUE)
  reticulate::use_python('/home/chief/anaconda3/bin/python3.7')
  miditapyr <<- reticulate::import("miditapyr")
}
