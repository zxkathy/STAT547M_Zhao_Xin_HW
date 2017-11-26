# STAT547M HW9

## Package Navigation

- The link to my [powers package](https://github.com/zxkathy/STAT547M_Zhao_Xin_HW/tree/master/HW9/powers)

- The link to my package [README](https://github.com/zxkathy/powers/blob/master/README.md)

- The link to my package [vignettes](https://github.com/zxkathy/powers/blob/master/vignettes/power_vignette.Rmd)

## Features of power package

This package contains 4 functions in total: 

- [squre()](https://github.com/zxkathy/powers/blob/master/R/square.R): take the square of a vector; 

- [boxcox()](https://github.com/zxkathy/powers/blob/master/R/boxcox.R): take the boxcox transformations of a vector,

- [boxcox.inv()](https://github.com/zxkathy/powers/blob/master/R/boxcox.inv.R): take the inverse boxcox transformations of a vector, `boxcox()` dependency
    
- [na.filter()](https://github.com/zxkathy/powers/blob/master/R/filter.na.R): filter out NA values by row or columns in a dataset, whether `row` or `col` should be specified by the user

## Report your progress

In this assignment, I extended and complete the `powers` package we designed in class, making three more functions while add a throw error argument for the existing  `square()` function. It was pretty fun and not hard designing the functions, however, the uploading and documentation makes this homework a little bit complicated to me.

I went through the [instructor's note](http://stat545.com/cm109-110-notes_and_exercises.html) again, and create another whole repository in github for this function, and found it could work finally. I am a little bit confused about the difference between package README.md file and vignettes.rmd file. After searching the website, I found some experienced programmers suggest that they should be identical. You can find more details in this [link](https://community.rstudio.com/t/readme-md-vs-package-vignette-vs-package-documentation/1359/3).
