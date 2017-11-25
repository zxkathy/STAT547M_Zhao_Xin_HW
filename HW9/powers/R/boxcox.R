#' Boxcox transformation of a vector
#'
#' Transforms via the Box-Cox transform.
#'
#' @param x The vector to be boxcoxed.
#' @param lambda The parameter of Box–Cox transformation
#'
#' @return A vector that is the boxcox transformation of \code{x}.
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
		res = log(x)
	}else{
		res = (x^lambda - 1)/lambda
	}
	return (res)
}

boxcox.inv <- function(x, lambda) 1/boxcox(x, lambda)
