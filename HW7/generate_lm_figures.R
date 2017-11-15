source('lib.R')
fireDat_ordered <- readRDS("ordered_fireDat.rds")

fireDat_RH <- 
	fireDat_ordered %>%
	filter(area > 0 & area< 100) %>%
	mutate(RH_l = if_else(RH < median(fireDat_ordered$RH), "RH-low", "RH-high"),
				 RH_lvl = as_factor(RH_l)) 


coefFireDat <- 
	fireDat_RH %>%
	group_by(RH_lvl) %>%
	nest() %>%
	mutate(fit_ls = map(data, ls_fit),
				 tidylm = map(fit_ls, tidy)) %>%
	unnest(tidylm)
write.table(coefFireDat, "coefFireDat.tsv", sep = "\t",
						row.names = FALSE, quote = FALSE)

lm_compa <-
	fireDat_RH %>%
	ggplot(aes(x = wind, y = area)) +
	geom_point() +
	geom_smooth(method = "lm") + 
	facet_grid(.~ RH_lvl, scales = "free") + 
	ylab("Burned area of the forest (in ha)") + 
	xlab("Wind speed in km/h") +
	ggtitle("Linear fit of forest burned are vs wind separated by relative humidity (RH) levels") + 
	theme_minimal()
print(lm_compa)

ggsave("lmComparison.png", lm_compa)