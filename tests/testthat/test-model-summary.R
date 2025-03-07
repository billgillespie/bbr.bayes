
test_that("nmbayes: model_summary() returns draws object", {
  expect_warning(res <- model_summary(NMBAYES_MOD1),
                 "not implemented")
  expect_s3_class(res, "draws")
  expect_identical(posterior::nchains(res), 2L)
})

test_that("stan: model_summary() correctly calls read_fit_model()", {
  expect_warning(
    res <- model_summary(STAN_MOD1)
  )
  expect_true(inherits(res, STAN_FIT_CLASS))

  # verify the sampler_diagnostics() method works
  smp <- res$sampler_diagnostics()
  expect_true(inherits(smp, STAN_SMP_DIAG_CLASS))
  expect_equal(dim(smp), STAN_SMP_DIAG_DIM)
})

test_that("stan gq: model_summary() correctly calls read_fit_model()", {
  expect_warning(res <- model_summary(STAN_GQ_MOD),
                 "not fully implemented")
  expect_s3_class(res, STAN_GQ_FIT_CLASS)
  expect_match(res$fitted_params_files(), "bern")
})
