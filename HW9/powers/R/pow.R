pow <- function(x, a=2){
	if(!is.numeric(x) && !is.logical(x))
		stop('Please input a numeric number or vector, or at least input a logical value!\n')
	else
		return(x^a)
	}
