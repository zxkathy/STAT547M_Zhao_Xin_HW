library(shinydashboard)
library(leaflet)
library(shinyjs)
library(V8)

ui <- shinyUI(dashboardPage(
	dashboardHeader(),
	dashboardSidebar(
		sidebarMenu(
			menuItem("Data Filter Selections")
		),
		
		sliderInput("yearInput", "Year Range Select:", 1917, 2017, c(2000, 2017)),
		checkboxGroupInput("continentInput", "Select Continent",
											 choices = c("All", "Africa", "Americas", "Asia", "Europe", "Oceania"),
											 selected = "All"),
		# conditionalPanel(
		# 	condition = ("continentSelect != All"),
		# 	selectInput("smoothMethod", "Method",
		# 							choices = list("lm", "glm", "gam", "loess", "rlm"))
		# ),
		downloadButton("downloadInput", "Download Data"),
		br(),
		br(),
		sidebarMenu(
			menuSubItem("Click here to show: Table", tabName = "tableFiltered", icon = icon("table")),
			menuSubItem("Click here to show: Map", tabName = "mapFiltered", icon = icon("map")),
			
			
			menuItem("Selected Data Analysis"),
			menuSubItem("Click: Histogram of damage levels", tabName = "histAnalysis", 
									icon = icon("align-left"))
		)
	),
	dashboardBody(
		h1(textOutput("resTitle")),
		h4(textOutput("searchResNo")),
		
		fluidRow( 
			valueBoxOutput("totCountry", width = 3),
			valueBoxOutput("ave_eq", width = 3),
			valueBoxOutput("ave_loss", width = 3),
			valueBoxOutput("ave_dep", width = 3)
		),
		
		tabItems(
			tabItem(tabName = "tableFiltered",
							fluidPage(
								DT::dataTableOutput("selectedTable")
							)
			),
			
			tabItem(tabName = "mapFiltered",
							fluidRow(
								radioButtons("displayInput", "Map Display Options", 
														 choices = c("Show labels and circles", "Show only labels", "Show only circles"),
														 selected = "Show labels and circles"),
								leafletOutput('selectedMap'))
			),
			tabItem(tabName = "histAnalysis",
							fluidPage(plotOutput("damageAnalysis")))
		)
	)
))
