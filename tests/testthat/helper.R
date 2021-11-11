library(zeallot)
install_miditapyr(envname = "r-reticulate")


skip_if_no_miditapyr <- function() {
  have_miditapyr <- reticulate::py_module_available("miditapyr")
  if (!have_miditapyr)
    skip("miditapyr not available for testing")
}

