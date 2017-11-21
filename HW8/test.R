library(shiny)
library(ggvis)
ui <- shinyUI(
	fluidPage(
	mainPanel(
		sliderInput("size", "Area", 10, 1000, value =10),
		uiOutput("ggvis_ui"),
		ggvisOutput("ggvis")
	)
))
server <- function(input, output) {
	input_size <- reactive(input$size)

	mtcars %>%
		ggvis(~disp, ~mpg, size := input_size) %>%
		layer_points() %>%
		bind_shiny("ggvis", "ggvis_ui")
}

shinyApp(ui, server)