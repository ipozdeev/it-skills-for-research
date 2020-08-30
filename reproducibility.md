# reproducibility

## notebooks

## interactive apps
### R shiny
An R shiny app is, well, an app &ndash; just a web program. Unlike other apps however, it is built using R and thus wraps the functionality of the latter in a pretty HTML/CSS design without the coder having to know much of HTML and CSS. You can create an entire page using nothing but R!

For a researcher who uses `R` to do the coding, `R shiny` is a marginally inexpensive step to give voice to their research project. As an example, consider a toy exercise of detecting the relation between stocks' market betas and expected returns. You have performed the calculations and present the results as follows:

![figures/bibtex-file-loc-example-nber.png](figures/beta-vs-mu.png)

When observing a graph like this, the audience might start asking questions:<br>
&ndash; What happens if you change the estimation window? <br>
&ndash; What is the stock over there with 60% average return? <br>
&ndash; How would excluding this stock change the results?

Now, imagine you could make the chart able to answer these questions. This is what an interactive app could indeed accomplish.

The following will give you an idea about `R shiny`. You are then encouraged to walk through [https://shiny.rstudio.com/articles/basics.html](https://shiny.rstudio.com/articles/basics.html) for more info.

### app structure
Although there are several ways to create an R shiny app, we would not go beyond writing it familiarly in an `.R` script. This script almost always has the following basic structure:
```
library(shiny)

# user interface is defined here
ui <- fluidPage()

# what your computer/server does is defined here
server <- function(input, output) {}

# this runs the app with the UI and server logic
shinyApp(ui = ui, server = server)

```
Just like in any app, two things need to be defined: a user interface, or how the app appears on the outside and how it communicates with the user; and the engine, or how the app works given the input. The user interface is defined in `ui <- fluidPage()`. This function simply creates a bunch of lines of HTML code for you, based on the arguments. You could have written these lines yourself, but `R` is ready to help you out here. The engine is written as a function operating on `input` and `output`. If you run the above few lines of code, `R` will command your web browser to will fire up and produce a web page with HTML written by the empty `fluidPage` call (hence a blank page).

### inputs and outputs
Inputs are variables that the user of the app can toggle inducing changes in the output of the app. `Shiny` offers several ways to do so: sliders, radio boxes, input fields etc., but behind each and every one is just some HTML code produced by `R`.
