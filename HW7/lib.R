library(broom)
library(dplyr)
library(ggplot2)
library(forcats)
library(reshape2)
library(tidyr)
library(purrr)

month_order <- c("jan", "feb", "mar", "apr", "may", "jun", 
								 "jul", "aug", "sep", "oct", "nov", "dec")
day_order <- c("sun", "mon", "tue", "wed", "thu", "fri", "sat")

ls_fit <- function(df) {
	lm(area ~ wind, data = df)
}