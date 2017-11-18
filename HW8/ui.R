#library(shinythemes)
library(leaflet)

ui <- fluidPage(
	#theme = shinytheme("flatly"),
	titlePanel("Significant Earthquake History"),
	sidebarPanel(
		sliderInput("yearInput", "Year Range Select:", 1700, 2017, c(1800, 1900)),
		checkboxGroupInput("continentInput", "Select Continent",
											 choices = c("Africa", "Americas", "Asia", "Europe", "Oceania"),
											 selected = "Africa")
	),
	mainPanel(
		tableOutput("selectedTable"),
		textOutput("searchResNo"),
		leafletOutput('selectedMap')
	)
)