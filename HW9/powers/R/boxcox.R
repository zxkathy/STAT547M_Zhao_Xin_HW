#' Boxcox/inverse boxcox transformation of a vector/number
#'
#' Transforms via the Box-Cox transform.
#'
#' @param x The vector to be boxcoxed/inverse boxcoxed.
#' @param lambda The parameter of Box–Cox transformation
#'
#' @return A vector/number that is the boxcox/inverse boxcox transformation of \code{x}.
#'
#' @details
#' We only do the boxcox transformations that only requires one input.
#'
#' @examples
#' boxcox(1:10, 2)
#' boxcox.inv(1:10, 2)
#' boxcox(2, 0)
#' boxcox.inv(2, 0)
#' @export
boxcox <- function(x, lambda){
	if(lambda == 0){
		if(length(x[x > 0]) != length(x)){
			stop('Please input positive number!\n')
		}else{
			res = log(x)
		}
	}else{
		res = (x^lambda - 1)/lambda
	}
	return(res)
}

boxcox.inv <- function(x, lambda) 1/boxcox(x, lambda)
