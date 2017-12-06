# library(httr)
# library(glue)
h <- list()

h[[1]] <- read_html("http://www.realestatevalley.ca/idx/search.html?refine=true&sortorder=DESC-ListingPrice&map%5Blongitude%5D=-123.138565&map%5Blatitude%5D=49.263588&map%5Bzoom%5D=12&search_city=Vancouver&idx=rebgv_idx&minimum_price=&maximum_price=&search_subdivision=Downtown+VW&search_area=&search_subtype=&minimum_bedrooms=2&maximum_bedrooms=&minimum_bathrooms=2&maximum_bathrooms=&minimum_sqft=&maximum_sqft=&minimum_acres=&maximum_acres=&minimum_year=&maximum_year=&search_location=Vancouver")

for(i in 2:9){
	link <- glue("http://www.realestatevalley.ca/idx/search.html?refine=true&sortorder=DESC-ListingPrice&map%5Blongitude%5D=-123.138565&map%5Blatitude%5D=49.263588&map%5Bzoom%5D=12&search_city=Vancouver&idx=rebgv_idx&minimum_price=&maximum_price=&search_subdivision=Downtown+VW&search_area=&search_subtype=&minimum_bedrooms=2&maximum_bedrooms=&minimum_bathrooms=2&maximum_bathrooms=&minimum_sqft=&maximum_sqft=&minimum_acres=&maximum_acres=&minimum_year=&maximum_year=&search_location=Vancouver&p={i}")
	h[[i]] <- 
		read_html(link)
}

