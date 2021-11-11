test_that("miditapyr module can be installed", {
  # logical if miditapyr available
  avail <- reticulate::py_module_available("miditapyr")
  # note with a skip when we didn't install something new
  if (avail) {
    message('miditapyr module was already installed')
  }

  # check that can be installed without error:
  expect_error(install_miditapyr(pip = TRUE), NA)



})
