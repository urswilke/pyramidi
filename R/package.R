# Using reticulate in an R Package
# See:
# https://rstudio.github.io/reticulate/articles/package.html

mido <- NULL

.onLoad <- function(mido, pkgname) {
  # use superassignment to update global reference to mido
  mido <<- reticulate::import("mido", delay_load = TRUE)
}
