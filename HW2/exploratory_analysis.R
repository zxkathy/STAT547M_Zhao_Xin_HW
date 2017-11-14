source('~/Dropbox/Kathy/Course/STAT545M/STAT547M_Zhao_Xin_HW/HW2/lib.R')

fireDat <- read.csv("forestFires.csv", header = TRUE, sep = ",") %>%
	na.omit()

#BEFORE REORDER:
unordered_count<-
	fct_count(fireDat$month) %>%
	rename(Month = f, Count = n) %>%
	ggplot(aes(x = Month, y = Count)) +
	geom_bar(stat = "identity", aes(fill = Count)) +
	ggtitle("Before reordering: Frequency barchart of forest fire by each month") +
	xlab("Month") +
	ylab("Forest fire count") + 
	theme_minimal()
print(unordered_count)

ggsave("unorderedCount.png", unordered_count)

#REORDER
fireDat$month <- 
	fireDat$month %>% 
	fct_relevel(month_order) 

fireDat$day <- 
	fireDat$day %>%
	fct_relevel(day_order) 

saveRDS(fireDat, "ordered_fireDat.rds")

# PLOT: Forest fire frequency by month
fireMonth <- 
	fct_count(fireDat$month) %>%
	rename(Month = f, Count = n)

ordered_count <- 
	fireMonth %>%
	ggplot(aes(x = Month, y = Count)) +
	geom_bar(stat = "identity", aes(fill = Count)) +
	ggtitle("After reordering: Frequency barchart of forest fire by each month") +
	xlab("Month") +
	ylab("Forest fire count") + 
	theme_minimal()

print(ordered_count)

ggsave("orderedCount.png", ordered_count)

#PLOT: Burned forest area of each month in descending order
fireMonthArea <- 
	fireDat %>%
	select(month, area) %>%
	group_by(month) %>%
	summarise(sum_area = sum(area)) %>%
	arrange(desc(sum_area)) %>%
	mutate(arr_month = fct_reorder(month, 
																 sum_area, fun = sum, .desc = TRUE)) %>%
	select(arr_month, sum_area)

saveRDS(fireMonthArea, "fire_Month_Area_Ordered.rds")

ordered_sum <-
	fireMonthArea %>%
	ggplot(aes(x = arr_month, y = sum_area)) +
	geom_bar(stat = "identity", aes(fill = sum_area)) +
	ggtitle("After reordering: Barchart of total burned forest by each month in descending order") +
	xlab("Month") +
	ylab("Total burned forest area") + 
	theme_minimal()

print(ordered_sum)

ggsave("orderedSum.png", ordered_sum)
