context("test-forecast.R")

test_that("Test fasster forecasting", {
  fc1 <- forecast(USAccDeaths_fit)
  expect_equal(NROW(fc1), 24)

  fc2 <- forecast(USAccDeaths_fit, h = 3)
  expect_equal(NROW(fc2), 3)

  future_idx <- tsibble::yearmonth(as.Date(USAccDeaths$index) + months(NROW(USAccDeaths)))
  fc3 <- forecast(USAccDeaths_fit, new_data = tsibble::as_tsibble(list(index = future_idx), index = index))
  expect_equal(NROW(fc3), NROW(USAccDeaths))

  expect_equal(fc1$value[1:3], fc2$value[1:3])
  expect_equal(fc1$value[1:3], fc3$value[1:3])
})
