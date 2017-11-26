#' Filter out the observations/features that contains the NA values within data.frame
#'
#' Tells whether the data input contains any NA values,
#' and filter out the NA values by user's specification - namely, either row or columne.
#'
#' @param x The dataframe needs to be checked.
#' @param direction user specify how the NA observations should be deleted,
#' by "row" or "col".
#'
#' @return A list with the first elemenet indicating whether ther is any missing values in the dataframe,
#' second element indicating the dataset with NA values omitted.
#'
#' @details
#' We only do the boxcox transformations that only requires one input.
#'
#' Here are some reasons why putting a list in this section is excessive:
#' \itemize{
#'      \item This \code{boxcox} function only requires one input.
#'      \item There's nothing else to say about \code{boxcox}.
#' }
#'
#' @examples
#' m <- as.data.frame(cbind(c(1,2,1), c(2,2,NA)))
#' filter.na(m, direction = "col")
#' filter.na(m, direction = "row")$FilteredData
#'
#' @export
filter.na <- function(x, direction){
	hasNA <- TRUE
	omit.x <- x
	res <- list()
	if(class(x) != 'data.frame')
		stop('Please input a data frame!\n')
	else if(nrow(x) == 0)
		stop('Please input a non-empty data frame!\n')
	else{
		if(nrow(x) == nrow(na.omit(x))){
			hasNA <- FALSE
		}else{
			if(direction == "row")
				omit.x <- data.frame(na.omit(x))
			else if(direction == "col")
				omit.x <- data.frame(t(na.omit(t(x))))
			else
				stop('Please input either "row" or "col" in direction!\n')
		}
	}
	return(list(ContainNA = hasNA, FilteredData = omit.x))
}


