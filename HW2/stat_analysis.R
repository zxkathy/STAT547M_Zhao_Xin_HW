source('~/Dropbox/Kathy/Course/STAT545M/STAT547M_Zhao_Xin_HW/HW2/lib.R')
fireDat_ordered <- readRDS("ordered_fireDat.rds")

# PLOT: Weekly forest fire frequency trend by month
#Make sure the order is still in force

fireDayMonth <-
	fireDat_ordered %>%
	select(month, day) %>%
	dcast(.,day ~ month) %>%
	gather(key = day, value)
names(fireDayMonth) <- c("Day", "Month", "Value")
fireDayMonth$Month <-
	as.factor(fireDayMonth$Month) %>%
	fct_relevel(month_order)
fireDayMonth$Day <-
	as.factor(fireDayMonth$Day) %>%
	fct_relevel(day_order)

saveRDS(fireDayMonth, "fire_Day_Month.RDS")

weeklyTrend <-
	fireDayMonth %>%
	group_by(Month) %>%
	ggplot(aes(x = Day, y = Value, group = Month, color = Month)) +
	geom_path(alpha = 0.9) +
	ylab("Forest fire count") +
	ggtitle("Weekly frequency trend of forest fire separated by each month") +
	theme_minimal()
print(weeklyTrend)

ggsave("weeklyTrend.png", weeklyTrend)


# PLOT:
lsfit <- function(df) {
	lm(area ~ wind, data = df)
}

# Find the best month that could use lm
fireDat_Month <-
	fireDat_ordered %>%
	group_by(month) %>%
	nest() %>%
	mutate(fit_ls = map(data, lsfit),
				 tidy = map(fit_ls, tidy)) %>%
	unnest(tidy)

write.table(fireDat_Month, "bestMonthAnalysis.tsv", sep = "\t",
						row.names = FALSE, quote = FALSE)

best_month_result <-
	fireDat_Month %>%
	filter(p.value <= 0.05)

write.table(best_month_result, "bestMonthRes.tsv", sep = "\t",
						row.names = FALSE, quote = FALSE)