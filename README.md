# it skills for research

A collection of skills for academic (not only) research, may be a bit finance-centric.

See [syllabus](syllabus.pdf) (outdated!) for details.

## prerequisites

- a 'heard-it-somewhere' understanding of computer science: what an operating system is, how virtual differs from physical or local from remote, why command line exists etc.;
- intermediate knowledge of Python, R or Julia: how to write a function, plot a chart, format string values, read to and write from text files etc.;
- previous exposure to research projects.

## table of contents

| date    | topic
| ----    | ----
| week 1  | [introduction](./introduction.md)<br/>[reproducibility](https://the-turing-way.netlify.app/welcome.html)<br/>[chatgpt](https://sites.google.com/view/lastunen/ai-for-economists)
| week 2  | [command line](./command-line.md)
| week 3  | [project environment](./project-environment.md)
| week 4  | [coding environment (docker)](./coding-environment.md)
| week 5  | [version control p1: working solo](./version-control.md)
| week 6  | [version control p2: collaboration](./collaboration-tools.md)
| week 7  | [data management p1: setting up a database](./data-management.md)
| week 8  | [data management p2: web api](./web-api.md)
| week 9  | [data management p3: introduction to SQL](./sql-basics.md)
| week 10 | [visualization](./visualization.md)
| week 11 | [publication p1: latex](./writing-with-latex.md)
| week 12 | [publication p2: apps](./apps.md)
| week 13 | [cloud computing](./cloud-computing.md)

## software

We will be using Slack, a command line terminal, ChatGPT, Python or R plus Jupyter (potentially with an IDE), an advanced text editor (such as Sublime Text or VS Code), git (potentially with dedicated software or integration into the text editor of choice), Docker and LaTeX (potentially with dedicated editors).

## examination

(100\%, group assignment, same grade, deadline 11-Dec-2024, defense by 20-Dec-2024)

The exam takes the form of a little research project, hosted on Github, submitted by the deadline above and defended in person later.

Please work in groups of 2-4 people; groups must be formed and a research topic selected before the 3rd lecture starts, the only allowed change after this deadline being leaving a group or joining one if left alone. Working alone is not allowed with no exceptions; use the `#teams` channel in Slack to find a group or look for group mates.

Some further requirements are:

- the repository is called informatively: do NOT use 'DigitalToolsForFinance', 'final-project', 'DTfFSubmission' etc.; 
- the main findings are on the default branch; 
- there is an informative README file:
  -  briefly describing your project and the main findings (with the main figure/table if applicable) - treat the README as an extended abstract of your research;
  -  describing in detail the steps needed to reproduce the findings; 
- all group members are contributors to the repository and have made meaningful commits;
- the repository is structured neatly and concisely, without the clutter of folders and files for which third people have no use (use .gitignore);
- work on the project consistently, avoid bulk commits;
- keep your data transparent and easy to replace or update;
- make figures and tables in line with the visualization standards discussed in class;
- write a short text paper and a beamer presentation using LaTeX, populate it with sections, a table of contents, a bibliography and the above tables and figures, and make sure anyone can compile the LaTeX code using docker (e.g. `texlive/texlive` image);
- create an interactive app (Shiny or Jupyter notebook) describing the main findings and presenting several robustness checks; the app should be self-explanatory and self-sufficient, and read like a paper, so please structure it in a user-friendly way and document all the steps with Markdown/HTML;
- make the project fully reproducible: dockerize it (all the steps!), export the coding environment for anyone to be able to run it locally, and prepare documentation; **anyone who could pass this course should be able to see and reproduce your findings from scratch**;
- have fun and feel academic-esque.

For the defense, you will be asked to reproduce your research and answer my questions down the road, such as how to set up the docker environment, compile the LaTeX for the presentation etc.; and every group participants is expected to be able to answer those.

You can pick a topic from the [list of suggested topics](./research-topics.md), but own topics are strongly encouraged! You can also choose to replicate a result from your favorite paper (which does not have an open-source implementation yet).

