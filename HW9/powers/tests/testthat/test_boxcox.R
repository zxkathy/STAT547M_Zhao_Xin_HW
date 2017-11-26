context("Boxcox transformations of numerics")

test_that("boxcox transformations when lambda is not 0.", {
	num_vec <- c(0, -4.6, 3.4)
	expect_identical(boxcox(num_vec, lambda = 3), (num_vec^3 - 1)/3)
})

test_that("boxcox transformations when lambda is 0.", {
	num_vec <- c(0.1, 0.5, 3)
	expect_identical(boxcox(num_vec, lambda = 0), log(num_vec))
})

test_that("boxcox transformations when lambda is 0, and x is negative.", {
	expect_error(boxcox(-3, lambda = 0), "Please input positive number!")
})

test_that("inv_boxcox transformations when lambda is not 0.", {
	num_vec <- c(-1.5, 0.5, 0)
	expect_identical(boxcox.inv(num_vec, lambda = -3), -3/(num_vec^(-3) - 1))
}

test_that("inv_boxcox transformations when lambda is 0.", {
	num_vec <- c(0.2, 1.5, 9)
	expect_identical(boxcox(num_vec, lambda = 0), log(num_vec))
})

test_that("inv_boxcox transformations when lambda is 0, and x is negative.", {
	expect_error(boxcox.inv(-3, lambda = 0), "Please input positive number!")
})
