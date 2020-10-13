test_that("python modules available", {
  # testthat::expect_true(reticulate::py_available())
  testthat::expect_true(reticulate::py_module_available("mido"))
  testthat::expect_true(reticulate::py_module_available("miditapyr"))
})
