# Using reticulate in an R Package
# See:
# https://rstudio.github.io/reticulate/articles/package.html

mido <- NULL
miditapyr <- NULL
reticulate::use_python('/home/chief/anaconda3/bin/python')
# reticulate::use_python("~/R/pyramidi/python/", required = T)
.onLoad <- function(libname, pkgname) {
  # use superassignment to update global reference to mido & miditapyr
  # miditapyr <<- reticulate::import("miditapyr", delay_load = TRUE)
  # library(reticulate)
  mido <<- reticulate::import("mido", delay_load = TRUE)
  path <- system.file("python", package = packageName())
  sys <- reticulate::import("sys", convert = FALSE)
  sys$path$append(path)
  miditapyr <<- reticulate::import("miditapyr", delay_load = TRUE)


  # reticulate::use_python('/home/chief/anaconda3/bin/python3.7')
  # miditapyr <<- reticulate::import("miditapyr")
  # miditapyr <<- reticulate::import_from_path(module = "miditapyr", path = system.file("python", "miditapyr", package = packageName()))
  # miditapyr <<- reticulate::import_from_path("miditapyr", system.file("python", "miditapyr", package = packageName(), mustWork = TRUE))
  # miditapyr <<- reticulate::import("miditapyr", delay_load = TRUE)
}
