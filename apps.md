# apps

- [apps](#apps)
  - [interactive apps](#interactive-apps)
    - [R shiny](#r-shiny)
    - [app structure](#app-structure)
    - [how server and ui talk](#how-server-and-ui-talk)
    - [starting with shiny](#starting-with-shiny)
  - [notebooks](#notebooks)
    - [starting with jupyter](#starting-with-jupyter)
      - [locally](#locally)
      - [using docker](#using-docker)
    - [text in jupyter](#text-in-jupyter)
  - [resources](#resources)
  - [exercises](#exercises)

The black-and-white paper appearing in a journal is by far the most used way of way of academic knowledge transfer, the runner-up being the conference talk. Both are for what it is worth a one-way channel, as there is limited to no chance for the intended audience to talk back. This might be a fine practice in disciplines like mathematics, but for everything that includes data analysis this regretfully means scarcer feedback, less credibility and quicker aging of results, to the point that the researcher themselves cannot reproduce the findings after some time has passed.

As an example, consider a toy exercise of detecting the relation between stocks' market betas and expected returns. You have performed some data analysis and present the results as follows:

<img src=./src/apps/beta-vs-mu.png width=500>

The audience start asking questions:

- What happens if you change the estimation window?
- What is the stock over there with 60% average return?
- How would excluding this stock change the results?

Answering these questions has a flair of sharing your *research flow* rather than just the results, and indeed, if you could teach the audience to re-tread your path, they would be able to answer all the above question themselves &ndash; and more, they would be able to *reproduce* your findings.

In this chapter we will discuss some modern alternatives to the black-and-white paper (beyond the paper in color) and where the concept of open source fits into the academic game.

## interactive apps

### R shiny

What if you could make the chart able to answer these questions, as showcased in this `R shiny` app: [https://ipozdeev.shinyapps.io/r-shiny/](https://ipozdeev.shinyapps.io/r-shiny)?

An `R shiny` app is a webpage that contains `R` components. Attached to it is a server with an open session of `R`, such that the moment the user changes inputs on the webpage, these changes are passed on to `R` and reflected in the output. `R shiny` apps wrap the functionality of `R` in a pretty HTML/CSS design without the coder having to know much of HTML and CSS. You can create an entire page using nothing but `R`!

For a researcher who uses `R` to do the coding, `R shiny` is a marginally inexpensive step to give voice to their research project.

The following is based on the [documentation](https://shiny.rstudio.com/articles/basics.html) and a [video tutorial](https://shiny.rstudio.com/tutorial/) you are encouraged to sit through.

### app structure

Although there are several ways to create an `R shiny` app, we would not go beyond writing it familiarly in an `.R` script. This script almost always has the following basic structure:

```R
library(shiny)

# user interface is defined here
ui <- fluidPage()

# what your computer/server does is defined here
server <- function(input, output) {}

# this runs the app with the UI and server logic
shinyApp(ui = ui, server = server)
```

Just like in any app, two things need to be defined: a user interface, or how the app appears on the outside and talks with the user; and the engine, or how the app works on the inside. The user interface is defined in `fluidPage()`. This function simply creates a bunch of lines of HTML code for you, based on the arguments. You could have written these lines yourself, but `R` is ready to help you out here. The engine is written as a function operating on two arguments: `input` and `output`. If you run the above few lines of code, `R` will command your web browser to fire up and produce a web page with HTML written by the empty `fluidPage` call (hence a blank page).

### how server and ui talk

The server and the UI communicate via the former's arguments `input` and `output` facilitated by a `reactive` environment.

Inputs flow from the UI to the server: these are variables that the user of the app can toggle. `Shiny` offers many ways to do so: sliders, radio boxes, drop-out menus and so on, each being a function ending in `...Input`. Again, behind those is just some HTML code produced by `R`. The input functions assign elements to container `input` &ndash; the first argument of `server` function above. For instance, `selectInput("frequency", ...)` is a drop-out menu with the choice being passed to the server as `input$frequency`.

Output functions, producing the reverse information flow and ending in `...Output`, are similar. For instance, `plotlyOutput("plot")` on the UI side would produce a plot based on `output$plot` to be found on the server side. Hence, all you need to do to show a plot is to render it within `server` and store as `output$plot`, then fetch it somewhere in `ui`.

One important feature of this communication is reactivity. Whenever an input value changes, for instance, when the slider is moved or a different element selected from a drop-out menu, this change must be passed on downstream to the receiver of this input. Unless the receiver is capable of understanding the change, the change is useless. Simple `R` functions, such as `plot_ly()`, are unable to understand this, which is the reason reactive functions, such as `renderPlotly`, are needed here, otherwise an error will be raised.

### starting with shiny

The easiest way to run a shiny app is to build a custom image from [rocker/shiny](https://hub.docker.com/r/rocker/shiny) installing the necessary R packages, and follow the [instructions](https://github.com/rocker-org/shiny) to run the app in a container exposing port 3838.

## notebooks

Instead of letting your findings talk back to audience, you might as well teach the audience how to reproduce your findings. In most cases this is easily achieved with Jupyter notebooks.

A Jupyter notebook is an app that runs in a web browser and allows to create and share interactive documents structured as cells that contain code, visualizations, equations and explanatory text. Jupyter has evolved from IPython and now accommodates many different programming languages: `R`, `Julia`, `C++`, etc. Jupyter is open source.

One jupyter notebook can be all you need to complete, present and publish a research project! It is code, formatted text, visuals, interactivity and reproducibility all in one document that can be easily shared or displayed. Notebooks provide a high didactic value allowing the target audience to better grasp the core concepts of research with hands-on examples.

For example, the paper on the [transformer architecture](https://arxiv.org/abs/1706.03762) that currently dominates other models in natural language processing tasks, is quite dense and would take long to replicate from scratch. Fortunately, Alexander Rush from the Harvard NLP team implemented the paper line-by-line in a [jupyter notebook](https://nlp.seas.harvard.edu/2018/04/03/attention.html) for the interested reader to click through.

### starting with jupyter

#### locally

To run `jupyter` notebooks locally you need a web browser and a `Python` installation. The recommended way is to install Anaconda distribution which comes with pre-packaged `jupyter` along with a suite of tools for data science.

To register additional kernels, e.g. `R`, you would need to install them from the language interpreter and make known to `jupyter`:

```R
install.packages("IRkernel")
IRkernel::installspec()
```

If you are using a python environment, say, `fresh-crisp-env`, which is not visible among the kernels in jupyter, you should register the corresponding kernel first:

```bash
conda activate fresh-crisp-env
conda install ipykernel
python -m ipykernel install --user --name fresh-crisp-env
```

For other configurations check [the official documentation](https://jupyter.org/install).

#### using docker

The easier way though is to use a container from one of [docker images](https://hub.docker.com/u/jupyter).

### text in jupyter

The text in a jupyter notebook is styled using markdown, which is a markup language like LaTeX:

> Markdown is a lightweight markup language for creating formatted text using a plain-text editor. ([wiki](https://en.wikipedia.org/wiki/Markdown))

"Lightweight" speaks for itself: markdown is way, way simpler than LaTeX and is totally comprehensible even without rendering (try to open any .md from this repo in a plain text editor!). In exchange for this simplicity it gives up a ton of power &ndash; a questionable trade-off unless you note that:

> Markdown is a text-to-HTML conversion tool for web writers. ([daringfireball](https://daringfireball.net/projects/markdown/))

meaning that markdown is essentially HTML, and HTML is nothing but a markup language itself!

> The HyperText Markup Language or HTML is the standard markup language for documents designed to be displayed in a web browser. ([wiki](https://en.wikipedia.org/wiki/HTML))

This way, for any style that is not covered by Markdown's syntax, you can simply use the powerful HTML, just like in R shiny apps.

Obviously, Github speaks markdown (you are looking at a proof), and hence is a good place to publish your notebooks. Also, with a suitable extension installed, a notebook with all its output can be converted to a .tex document or compiled to a .pdf directly.

TODO: 'more markdown than code!'

## resources

- [getting started with markdown](https://www.markdownguide.org/getting-started);
- interactivity in ipython: [ipywidgets](https://ipywidgets.readthedocs.io/en/latest/).

## exercises

1. clone/update `digital-tools-for-finance` repo and use `renv` to install the dependencies needed to run the app in `src/apps/r-shiny` or use docker to do so;
2. add another input control to the `r-shiny-tutorial` app to include/exclude stocks from the OLS estimation and chart;
3. create a jupyter kernel of a virtual environment;
4. create a new jupyter notebook with code and markdown-styled text cells;
5. use `ipywidgets` to add interactive elements to your notebook;
6. save, commit and push the notebook to Github; make sure it appears with the output (the interactive elements won't work of course);
7. clone the annotated transformer notebook and install the requirements, then make sure you can run the cells.
