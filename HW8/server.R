library(dplyr)
library(leaflet)
library(stringr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(shinyjs)
library(V8)
library(ggvis)

server <- shinyServer(function(input, output, session) { 
	dat <- read.csv("data/dat.csv", header = T)
	
	filteredDat <- reactive({
		if(input$continentInput != "All"){
			dat %>%
				filter(YEAR >= input$yearInput[1],
							 YEAR <= input$yearInput[2],
							 CONTINENT %in% input$continentInput)
		}else{
			dat %>%
				filter(YEAR >= input$yearInput[1],
							 YEAR <= input$yearInput[2])
		}
	})
	
	# continentSelect <- reactive({
	# 	switch(input$continentInput,
	# 				 "Africa" = africa,
	# 				 "Americas" = americas, 
	# 				 "Asia" = asia, 
	# 				 "Europe" = europe, 
	# 				 "Oceania" = oceania)
	# })
	# 
	# output$nrows <- reactive({
	# 	nrow(continentSelect())
	# })
	
	output$resTitle<- renderText({
		str_to_upper("Result Display")
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
	
	output$plotTitle <- renderText({
		"Scatterplot of EQ_PRIMARY vs FOCAL_DEPTH on Full Data"
	})
		
	output$histTitle <- renderText({
		"Histogram of DAMAGE_DESCRIPTION on Selected Data"
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
	
	output$totCountry <- renderValueBox({
		count <- nrow(filteredDat())
		valueBox(count,"Countries Affected",icon = icon("flag-o"), color = 'green') })
	output$ave_eq <- renderValueBox({
		valueBox(round(mean(na.omit(filteredDat()[,"EQ_PRIMARY"])),2),
						 "Average EQ Primary",icon = icon("globe"), color = 'red') })
	output$ave_dep <- renderValueBox({
		valueBox(round(mean(na.omit(filteredDat()[,"FOCAL_DEPTH"])),2),
						 "Average EQ Depth",icon = icon("spinner"), color = 'blue') })
	output$ave_loss <- renderValueBox({
		valueBox(round(mean(na.omit(filteredDat()[,"DAMAGE_DESCRIPTION"])),2),
						 "Average Loss",icon = icon("dollar"), color = 'yellow') })
	
	
	output$damageAnalysis <- renderPlot({
		filteredDat()%>%
			na.omit() %>%
			ggplot(aes(x = DAMAGE_DESCRIPTION, fill = CONTINENT)) +
			geom_bar() +
			xlab("Damage Level") +
			ylab("# of earthquakes") +
			coord_flip()
		
	})

	input_size <- reactive(input$size)
	input_slid <- reactive(input$slider)
	
	dat %>%
		na.omit() %>%
		ggvis(~EQ_PRIMARY, ~FOCAL_DEPTH) %>%
		layer_points(size := input_size) %>%
		layer_points(fill := "red", opacity := 0.3, size := input_size) %>%
		layer_smooths(span = input_slid) %>%
		bind_shiny("ggvis", "ggvis_ui")
	
	
}
)
