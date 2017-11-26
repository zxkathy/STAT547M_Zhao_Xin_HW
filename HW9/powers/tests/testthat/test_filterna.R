context("NA filtering test")

test_that("NA filter function needs data frame input.", {
	expect_error(filter.na(cbind(c("A", 1), c(NA, "m")), direction = "row"),
							 "Please input a data frame!")
})

test_that("NA filter on no missing value data frame.", {
	dat <- as.data.frame(cbind(c(0, -4.6), c(0, 0)))
	expect_identical(filter.na(dat, direction = "row")$ContainNA, FALSE)
	expect_identical(filter.na(dat, direction = "row")$FilteredData, dat)
})

test_that("NA filter by row.", {
	dat <- as.data.frame(cbind(c(0, -4.6, 3.4), c(0, NA, 3.1)))
	expect_identical(filter.na(dat, direction = "row")$ContainNA, TRUE)
	expect_identical(filter.na(dat, direction = "row")$FilteredData,
									 data.frame(na.omit(dat)))
})

test_that("NA filter by col.", {
	dat <- as.data.frame(cbind(c(0, -4.6), c(0.7, NA)))
	expect_identical(filter.na(dat, direction = "col")$ContainNA, TRUE)
	expect_identical(filter.na(dat, direction = "col")$FilteredData,
									 data.frame(V1 = matrix(c(0, -4.6), ncol = 1)))
})
