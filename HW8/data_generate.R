library(dplyr)
library(stringr)
eq_dat <- read.delim("data/eq_data.tsv")
gp_dat <- read.csv("data/gp_data.csv", header = T)
dat_join <- inner_join(eq_dat, gp_dat, by = 'COUNTRY') %>%
	filter(YEAR >= 1917,
				 LONGITUDE > 0, 
				 LATITUDE > 0,
				 EQ_PRIMARY > 0) 

dat_na <- 
	dat_join%>%
	mutate(LOCATION = if_else(COUNTRY == "USA", 
														str_c("USA: ", LOCATION_NAME, sep = ""), 
														as.character(LOCATION_NAME)),
				 DATE = str_c(YEAR, "/", MONTH, "/", DAY), 
				 TIME = str_c(HOUR, ":", MINUTE, ":", SECOND)) %>%
	select(-c(LOCATION_NAME, STATE, MINUTE:SECOND))

p <- c()
for(i in 1:ncol(dat_na)){
	p[i] <- sum(is.na(dat_na[,i]))/nrow(dat_na)
}
dat <- dat_na[, which(p < 0.2)]

write.csv(dat, "data/dat.csv")
