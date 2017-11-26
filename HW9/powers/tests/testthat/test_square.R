context("Squaring non-numerics")

test_that("At least numeric values work.", {
	num_vec <- c(0, -4.6, 3.4)
	expect_identical(square(numeric(0)), numeric(0))
	expect_identical(square(num_vec), num_vec^2)
})

test_that("Non-numeric values does not work.", {
	num_vec_char <- "c(0, -4.6, 3.4)"
	expect_error(square(num_vec_char),
							 "Please input a numeric number or vector, or at least input a logical value!")
})

test_that("Logicals automatically convert to numeric.", {
	logic_vec <- c(TRUE, TRUE, FALSE)
	expect_identical(square(logic_vec), logic_vec^2)
})
