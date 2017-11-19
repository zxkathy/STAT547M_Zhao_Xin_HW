library(dplyr)
library(leaflet)
library(stringr)
library(shiny)
library(shinydashboard)


server <- shinyServer(function(input, output) { 
	dat <- read.csv("data/dat.csv", header = T)
	dat$CONTINENT == "Ocenia"
	filteredDat <- reactive({
		dat %>%
			dplyr::filter(YEAR >= input$yearInput[1],
										YEAR <= input$yearInput[2],
										CONTINENT %in% input$continentInput)
	})
	output$introTitle<- renderText({
		str_to_upper("Introduction")
	})
	output$intro <- renderText({
		"The Significant Earthquake Database contains information on destructive earthquakes 
		from 2150 B.C. to the present that meet at least one of the following criteria: Moderate 
		damage (approximately $1 million or more), 10 or more deaths, Magnitude 7.5 or greater, 
		Modified Mercalli Intensity X or greater, or the earthquake generated a tsunami. "
	})
	output$dataTitle<- renderText({
		str_to_upper("Data Description")
	})		
	output$ourData <- renderText({
		str_c("In our case, I combined this dataset with gapminder dataset to get the continent feature 
		so that the users could do initial selection by continent. Also, I extracted the data in 
					the past 100 years, and select the features that are at least 80% complete to make the app
					response quickly and accurately.")
	})
	output$howWork<- renderText({
		str_to_upper("App Description")
	})		
	output$workFlow <- renderText({
		str_c("In this webpage, your can download a subset of the processed data according to your own 
					choosing criteria, also, you will have an idea of the earthquake location and magnitude 
					from the map view. You will find more interactive functions on your own, enjoy!")
	})
	output$resTitle<- renderText({
		str_to_upper("Result")
	})		
	output$searchResNo <- renderText({
		str_c("We found ", nrow(filteredDat())," 
					search results according to your search criteria, 
					click corresponding sidebar to check details.", sep="")
	})
	
	output$downloadInput <- downloadHandler(
		filename = function() {
			paste("filteredData.csv", sep = "")
		},
		content = function(file) {
			write.csv(filteredDat(), file, row.names = FALSE)
		}
	)
	
	output$selectedTable <- DT::renderDataTable({
		filteredDat() %>%
			select(ID = I_D, DATE, TIME, LOCATION, FOCAL_DEPTH, EQ_PRIMARY, FLAG_TSUNAMI, 
						 DAMAGE = DAMAGE_DESCRIPTION, LATITUDE, LONGITUDE, CONTINENT)
	})
	

	output$selectedMap <- renderLeaflet({
		if(input$displayInput == "Show labels and circles"){
			leaflet(data = filteredDat()) %>%
				addTiles() %>%
				addMarkers(~LONGITUDE, ~LATITUDE, popup = ~LOCATION,
									 clusterOptions = markerClusterOptions()) %>%
				addCircles(lng = ~LONGITUDE, lat = ~LATITUDE, weight = 1,
									 radius = ~EQ_PRIMARY*1e+5, popup = ~LOCATION)
		}
		else if(input$displayInput == "Show only labels"){
			leaflet(data = filteredDat()) %>%
				addTiles() %>%
				addMarkers(~LONGITUDE, ~LATITUDE, popup = ~LOCATION,
									 clusterOptions = markerClusterOptions())
		}
		else{
			leaflet(data = filteredDat()) %>%
				addTiles() %>%
				addCircles(lng = ~LONGITUDE, lat = ~LATITUDE, weight = 1,
									 radius = ~EQ_PRIMARY*1e+5, popup = ~LOCATION)
		}
	})
	
	
	
}
)
