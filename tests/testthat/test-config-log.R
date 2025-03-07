
### NONMEM Bayes

test_that("nmbayes: config_log() works", {
  skip("FIXME: submodels confuse config_log()")
  log_df <- config_log(NMBAYES_ABS_MODEL_DIR)
  expect_equal(log_df[[RUN_ID_COL]], NMBAYES_MOD_ID)
  expect_match(log_df[["bbi_version"]], "^v[0-9]+\\.[0-9]+\\.[0-9]+$")
  expect_false(log_df[["model_has_changed"]])
  expect_false(log_df[["data_has_changed"]])
})

### Stan

test_that("stan: config_log() works", {
  log_df <- config_log(STAN_ABS_MODEL_DIR)
  expect_identical(log_df[[RUN_ID_COL]],
                   c(STAN_GQ_MOD_ID, STAN_MOD_ID3, STAN_MOD_ID))
  expect_identical(log_df[["bbi_version"]],
                   rep(STAN_BBI_VERSION_STRING, 3))
  expect_false(any(log_df[["model_has_changed"]]))
  expect_false(any(log_df[["data_has_changed"]]))
})

test_that("stan: config_log() builds data", {
  perturb_file(
    system.file("extdata", "fxa.data.csv", package = "bbr.bayes"),
    txt = paste(rep(99, 8), collapse = ",")
  )
  log_df <- config_log(STAN_ABS_MODEL_DIR)
  expect_identical(log_df[[RUN_ID_COL]],
                   c(STAN_GQ_MOD_ID, STAN_MOD_ID3, STAN_MOD_ID))
  expect_identical(log_df[["bbi_version"]],
                   rep(STAN_BBI_VERSION_STRING, 3))
  expect_false(any(log_df[["model_has_changed"]]))
  expect_identical(log_df[["data_has_changed"]],
                   c(FALSE, FALSE, TRUE))
})
