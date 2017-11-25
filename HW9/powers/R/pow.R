pow <- function(x, a=2){
	if(!is.numeric(x))
		stop('Please input a numeric number!\n')
	else
		return(x^a)
	}
