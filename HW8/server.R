library(dplyr)
library(leaflet)
library(stringr)

function(input, output) {
	dat <- read.csv("data/dat.csv", header = T)
	
	filteredDat <- reactive({
		dat %>%
			dplyr::filter(YEAR >= input$yearInput[1],
										YEAR <= input$yearInput[2],
										CONTINENT == input$continentInput)
	})
	
	output$selectedTable <- renderTable({
		head(filteredDat())
	})
	
	output$searchResNo <- renderText({
		str_c("We found ", nrow(filteredDat())," search results according to your search criteria, click to check details.", sep="")
	})
		
	output$selectedMap <- renderLeaflet({

		leaflet(data = filteredDat()) %>%
			addTiles() %>%
			addMarkers(~LONGITUDE, ~LATITUDE, popup = ~LOCATION)
	})
}