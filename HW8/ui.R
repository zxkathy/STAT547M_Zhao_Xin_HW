library(shinydashboard)
library(leaflet)

ui <- shinyUI(dashboardPage(
	dashboardHeader(),
	dashboardSidebar(
		
		menuItem("Data Filter Selections"),
		sliderInput("yearInput", "Year Range Select:", 1917, 2017, c(2000, 2017)),
		checkboxGroupInput("continentInput", "Select Continent",
											 choices = c("Africa", "Americas", "Asia", "Europe", "Oceania"),
											 selected = "Africa"),
		menuSubItem("Click here to show: Table", tabName = "tableFiltered", icon = icon("table")),
		menuSubItem("Click here to show: Map", tabName = "mapFiltered", icon = icon("map")),
		menuSubItem("Download selected table", icon = icon("download")),
		downloadButton("downloadInput", "Download Data"),
		br(),
		br(),
		menuItem("Selected Data Analysis")
	),
	dashboardBody(
		h1(textOutput("introTitle")),
		h4(textOutput("intro")),
		h1(textOutput("dataTitle")),
		h4(textOutput("ourData")),
		h1(textOutput("howWork")),
		h4(textOutput("workFlow")),
		h1(textOutput("resTitle")),
		h4(textOutput("searchResNo")),
		br(),
		
		tabItems(
			tabItem(tabName = "tableFiltered",
							fluidRow(
								DT::dataTableOutput("selectedTable")
							)
			),
			tabItem(tabName = "mapFiltered",
							fluidRow(
								radioButtons("displayInput", "Map Display Options", 
														 choices = c("Show labels and circles", "Show only labels", "Show only circles"),
														 selected = "Show labels and circles"),
								leafletOutput('selectedMap'))
			)
		)
	)
))
