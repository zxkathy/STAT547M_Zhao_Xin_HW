# Homework 8: Building Shiny apps


## APP DATA DESCRIPTION:

The Significant Earthquake Database obtained from NOAA is my main data source. It contains information on destructive earthquakes 
		from 2150 B.C. to the present that meet at least one of the following criteria: Moderate 
		damage (approximately $1 million or more), 10 or more deaths, Magnitude 7.5 or greater, 
		Modified Mercalli Intensity X or greater, or the earthquake generated a tsunami.

In my case, I combined this dataset with gapminder dataset to get the continent feature 
		so that the users could do initial selection by continent. Also, I extracted the data in 
					the past 100 years, and select the features that are at least 80% complete to make the app response quickly and accurately.
					
This app features with several functions, but mainly could be categorized into two parts: 

1. Filter the data according to the client's requirement;

2. Do corresponding statistical analysis.
								
					
## APP LINKS:

https://zxkathy.shinyapps.io/earthquake_in_the_past_100_years_analysis/


## APP FEATURES:

In this webpage, your can download a subset of the processed data according to your own choosing criteria, also, you will have an idea of the earthquake location and magnitude from the map view. You will find more interactive functions on your own, enjoy!
					
- #### Functional features

	+ Show the number of results found whenever the filters change;

	+ Use the DT package to turn the current results table into an interactive table;
	
## Data source

1. National Geophysical Data Center / World Data Service (NGDC/WDS): Significant Earthquake Database. National Geophysical Data Center, NOAA. doi:10.7289/V5TD9V7K

2. http://www.gapminder.org/data/

	+ Experiment with packages that add extra features to Shiny, such as `shinyjs`, `leaflet`, `shinydashboard`, `ggvis`;

	+ Allow the user to download the results table as a `.csv` file;

	+ Allow the user to search for multiple continents simultaneously;

	+ Provide a way for the user to show results from `all` continents.

	+ ... and much more!

- #### Beaty features

	+ Place the plot and the table in separate tabs;

	+ Add an image of the UI.

	+ ... and much more!
