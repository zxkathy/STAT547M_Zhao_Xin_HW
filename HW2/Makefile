all: report.html

clean:
	rm -f *.csv *.rds *.html *.png *.md *.tsv

report.html: report.rmd ordered_fireDat.rds forestFires.csv fire_Day_Month.rds fire_Month_Area_Ordered.rds bestMonthAnalysis.tsv bestMonthRes.tsv
	Rscript -e 'rmarkdown::render("$<")'

fire_Day_Month.rds fire_Month_Area_Ordered.rds bestMonthAnalysis.tsv bestMonthRes.tsv: stat_analysis.R ordered_fireDat.rds lib.R
	Rscript $<
	
ordered_fireDat.rds: exploratory_analysis.R forestFires.csv
	Rscript $<
	rm Rplots.pdf

forestFires.csv:
	Rscript download.r