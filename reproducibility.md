# reproducibility

## notebooks
### What are (jupyter) notebooks?
The Jupyter Notebook is an app that runs within a web browser and allows us to create and share interactive documents that contain code, visualizations, equations and explanatory text. Jupyter has evolved from IPython and now accommodates many different programming languages: R, Julia, C++, etc. Jupyter is open source.

### Why jupyter?
Notebooks are easy to share and are a perfect medium to communicate the exact step-by-step process leading to the results of a research project. Hence their importance for reproducibility. Notebooks are interactive and hence provide a high didactic value allowing the target audience to better grasp the core concepts of research given hands-on examples

### Installation
To run jupyter notebooks you need a Python installation. The recommended way is to install Anaconda distribution which comes with pre-packaged jupyter along with a suite of tools for data science. For other configurations check [the official documentation](https://jupyter.org/install).

### Starting a new notebook
To start a notebook open the command prompt, then navigate to the directory you will be working in and type in `jupyter notebook`. The command will start a notebook server which should be running while you are working in the notebook. For additional information like running the server using a custom IP or port, refer to [this page](https://jupyter.readthedocs.io/en/latest/running.html). The notebook will run in your browser. The first thing you see will be a dashboard where you can navigate in different directories and create new notebooks.

Happy coding!

## interactive apps
### R shiny
An R shiny app is, well, an app &ndash; just a web program. Unlike other apps however, it is built using R and thus wraps the functionality of the latter in a pretty HTML/CSS design without the coder having to know much of HTML and CSS. You can create an entire page using nothing but R!

For a researcher who uses `R` to do the coding, `R shiny` is a marginally inexpensive step to give voice to their research project. As an example, consider a toy exercise of detecting the relation between stocks' market betas and expected returns. You have performed the calculations and present the results as follows:

![figures/bibtex-file-loc-example-nber.png](figures/beta-vs-mu.png)

When observing a graph like this, the audience might start asking questions:<br>
&ndash; What happens if you change the estimation window? <br>
&ndash; What is the stock over there with 60% average return? <br>
&ndash; How would excluding this stock change the results?

Now, imagine you could make the chart able to answer these questions. This is what an interactive app could indeed accomplish, as showcased here: [https://ipozdeev.shinyapps.io/r-shiny-tutorial/](https://ipozdeev.shinyapps.io/r-shiny-tutorial/).

The following will give you an idea about `R shiny`. You are then encouraged to walk through [https://shiny.rstudio.com/articles/basics.html](https://shiny.rstudio.com/articles/basics.html) on your own.

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

## open source in research
Open source is a concept in intellectual property meaning that everyone is granted the right to inspect and use some product's source code, design or the like. Linux is an open source project, but Windows is not. Everyone can inspect the source code of Linux to exclude possibility of ill intentions such as surveillance and unauthorized data collection; Windows is by and large inaccessible to such inspection.

Most research projects are Windows-like: although the methodology is usually to be found in the paper, much remains unreported, especially the code behind the calculations. Replication and fact checking could thus take an interested person days, and given the size of the global academic community, thousands of human-hours are possibly wasted on redundant replication attempts. At the same time, the marginal effort for the author to provide a clear reusable code is disproportionately smaller. Still, it being not-zero and offering little remuneration, is an obstacle and arguably the reason why we see it once in a blue moon.
