library(dplyr)
eq_dat <- read.delim("data/eq_data.tsv")
gp_dat <- read.csv("data/gp_data.csv", header = T)
dat_join <- inner_join(eq_dat, gp_dat, by = 'COUNTRY') %>%
	filter(YEAR >= 1700,
				 LONGITUDE > 0, 
				 LATITUDE > 0) 

dat <- 
	dat_join%>%
	mutate(LOCATION = if_else(COUNTRY == "USA", 
														str_c("USA: ", LOCATION_NAME, sep = ""), 
														as.character(LOCATION_NAME))) %>%
	select(-LOCATION_NAME)

write.csv(dat, "data/dat.csv")
