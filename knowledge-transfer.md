# knowledge transfer / reproducibility

- [knowledge transfer / reproducibility](#knowledge-transfer--reproducibility)
  - [coding environment](#coding-environment)
  - [interactive apps](#interactive-apps)
    - [R shiny](#r-shiny)
    - [app structure](#app-structure)
    - [how server and ui talk](#how-server-and-ui-talk)
  - [notebooks](#notebooks)
    - [what are (jupyter) notebooks?](#what-are-jupyter-notebooks)
    - [why jupyter?](#why-jupyter)
    - [installation](#installation)
    - [starting a new notebook](#starting-a-new-notebook)
  - [exercises](#exercises)

The black-and-white paper appearing in a journal is by far the most used way of way of academic knowledge transfer, the runner-up being the conference talk. Both are for what it is worth a one-way channel, as there is limited to no chance for the intended audience to talk back. This might be a fine practice in disciplines like mathematics, but for everything that includes data analysis this regretfully means scarcer feedback, less credibility and quicker aging of results, to the point that the researcher themselves cannot reproduce the findings after some time has passed.

As an example, consider a toy exercise of detecting the relation between stocks' market betas and expected returns. You have performed some data analysis and present the results as follows:

<img src=./src/knowledge-transfer/beta-vs-mu.png width=500>

The audience start asking questions:

- What happens if you change the estimation window?
- What is the stock over there with 60% average return?
- How would excluding this stock change the results?

Answering these questions has a flair of sharing your *research flow* rather than just the results, and indeed, if you could teach the audience to re-tread your path, they would be able to answer all the above question themselves &ndash; and more, they would be able to *reproduce* your findings.

In this chapter we will discuss some modern alternatives to the black-and-white paper (beyond the paper in color) and where the concept of open source fits into the academic game.

## coding environment

First, let us talk about how to share which software you use. This might be a non-trivial task if you are developing in Python or R and clearly relying on interdependent packages. A snapshot of these packages constitutes you working *environment*, and a precise description thereof is as essential for anyone interested in replicating your research as the data and the code itself.

In `R`, a good solution is [`packrat`](http://rstudio.github.io/packrat/). When in the project folder, executing `packrat::init()` tells the library to create folder `packrat/` with a bunch of configuration files and to relocate your current working environment to this folder (it has the familiar `lib/`, `bin/` etc.). From now on, the packages that you once installed in the home `R` folder are ignored, and the ones you will install appear in `packrat/lib/`. More in [this great SE answer](https://stackoverflow.com/a/38949039/2835160).

In Python, you would normally use a virtual environment to be easily created with [`venv`](https://docs.python.org/3/library/venv.html#module-venv) or [`conda`](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).

## interactive apps

### R shiny

What if you could make the chart able to answer these questions, as showcased in this `R shiny` app: [https://ipozdeev.shinyapps.io/r-shiny-tutorial/](https://ipozdeev.shinyapps.io/r-shiny-tutorial/).

An `R shiny` app is a webpage that contains `R` components. Attached to it is a server with an open session of `R`, such that the moment the user changes inputs on the webpage, these changes are passed on to `R` and reflected in the output. `R shiny` apps wrap the functionality of `R` in a pretty HTML/CSS design without the coder having to know much of HTML and CSS. You can create an entire page using nothing but `R`!

For a researcher who uses `R` to do the coding, `R shiny` is a marginally inexpensive step to give voice to their research project.

The following is based on the [video tutorial](https://shiny.rstudio.com/tutorial/) and [documentation](https://shiny.rstudio.com/articles/basics.html) you are encouraged to sit through.

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

Here is the source of the betas-vs-returns app:

```R
# UI is a fluid environment with (1) a title, (2) a sidebar with controls and
#   (3) a main plotting area
ui <- fluidPage(
  # (1) draw a panel containing the title as a h1-level header.
  titlePanel(h1("market betas vs. average returns")),

  sidebarLayout(
    # (2) controls with an h2-level header
    sidebarPanel(
      h2("controls"),
      br(),
      selectInput("frequency",
                  label = "select frequency",
                  choices = list("daily" = "daily",
                                 "monthly" = "monthly",
                                 "yearly" = "yearly"),
                  selected = "daily"),
    ),
    # (3) plotting area with an h2-level header
    mainPanel(
      h2("results"),
      plotlyOutput("plot")
    )
  )
)

# server logic: 1) fetch the data, 2) calculate betas based on the input from
#   controls above, 3) render a plot
server <- function(input, output) {
  # get data
  r <- get_stock_data()

  # calculate betas based on the input data frequency
  inputB = reactive({
    calculate_betas(r, freq = input$frequency, mkt_col = "SPY")
  })

  # plot
  output$plot <- renderPlotly({<some code to plot>})
}

# this runs the app
shinyApp(ui = ui, server = server)
```

## notebooks

Instead of letting your findings talk back to audience, you might as well teach the audience how to replicate your findings. In 99% cases this is easily achieved with Jupyter Notebooks.

### what are (jupyter) notebooks?

The jupyter notebook is a way for the coder to make guided tours through their work. It is an app that runs within a web browser and allows to create and share interactive documents that contain code, visualizations, equations and explanatory text. Jupyter has evolved from IPython and now accommodates many different programming languages: `R`, `Julia`, `C++`, etc. Jupyter is open source.

### why jupyter?

Notebooks are easy to share and are a perfect medium to communicate the exact step-by-step process leading to the results of a research project. Hence their importance for reproducibility. Notebooks are interactive and hence provide a high didactic value allowing the target audience to better grasp the core concepts of research given hands-on examples. Notebooks are a promising alternative to slides-based presentations, just as interactive apps are to papers.

For example, [the transformer architecture](https://arxiv.org/abs/1706.03762) currently dominates other models in many natural language processing tasks. The original paper, however, is extremely dense and would take days to replicate from scratch. Fortunately, Alexander Rush from the Harvard NLP team implemented the paper line-by-line in a [jupyter notebook](https://nlp.seas.harvard.edu/2018/04/03/attention.html).

### installation

To run `jupyter` notebooks you need a `Python` installation. The recommended way is to install Anaconda distribution which comes with pre-packaged `jupyter` along with a suite of tools for data science.
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

### starting a new notebook

To start a notebook open the command prompt, then navigate to the directory you will be working in and type in `jupyter notebook`. The command will start a notebook server which should be running while you are working in the notebook. For additional information like running the server using a custom IP or port, refer to [this page](https://jupyter.readthedocs.io/en/latest/running.html). The notebook will run in your browser. The first thing you see will be a dashboard where you can navigate in different directories and create new notebooks.

Happy coding!

## exercises

1. clone/update `digital-tools-for-finance` repo and use `packrat` to install the dependencies needed to run the app in `r-shiny-tutorial/`;
1. add another input control to the `r-shiny-tutorial` app to add/exclude stocks from the OLS estimation and chart;
1. create own virtual environment;
1. make it portable to another computer;
1. register the environment as a jupyter kernel;
1. create a new jupyter notebook and produce some output;
1. save, commit and push the notebook to Github; make sure it appears with the output.
1. clone the annotated transformer notebook and install the requirements, then make sure you can run the cells.
