library(magrittr)
library(zeallot)
if (!testthat:::on_ci()) {
  reticulate::use_python("/home/chief/anaconda3/bin/python", required = TRUE)
}


skip_if_no_miditapyr <- function() {
  have_miditapyr <- reticulate::py_module_available("miditapyr")
  if (!have_miditapyr)
    skip("miditapyr not available for testing")
}

