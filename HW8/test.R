library(shiny)

shinyApp(
	ui = fluidPage(
		useShinyjs(),  # Set up shinyjs
		actionButton("btn", "Click me"),
		textInput("text", "Text")
	),
	server = function(input, output) {
		observeEvent(input$btn, {
			# Change the following line for more examples
			toggle("text")
		})
	}
)