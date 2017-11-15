all: report.html

clean:
	rm -f *.csv *.rds *.html *.png *.md *.tsv

report.html: report.rmd ordered_fireDat.rds forestFires.csv fire_Day_Month.rds fire_Month_Area_Ordered.rds bestMonthAnalysis.tsv bestMonthRes.tsv lmComparison.png coefFireDat.tsv
	Rscript -e 'rmarkdown::render("$<")'

lmComparison.png coefFireDat.tsv: generate_lm_figures.R ordered_fireDat.rds
	Rscript $<
	rm Rplots.pdf

fire_Day_Month.rds fire_Month_Area_Ordered.rds bestMonthAnalysis.tsv bestMonthRes.tsv: stat_analysis.R ordered_fireDat.rds lib.R
	Rscript $<
	rm Rplots.pdf
	
ordered_fireDat.rds: exploratory_analysis.R forestFires.csv
	Rscript $<
	rm Rplots.pdf

forestFires.csv:
	Rscript download.r