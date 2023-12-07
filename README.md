# it skills for research

A collection of skills for academic (not only) research, may be a bit finance-centric.

See [syllabus](syllabus.pdf) for details.

## prerequisites

- a 'heard-it-somewhere' understanding of computer science: what an operating system is, how virtual differs from physical or local from remote, why command line exists etc.;
- intermediate knowledge of Python, R or Julia: how to write a function, plot a chart, format string values, read to and write from text files etc.;
- previous exposure to research projects.

## table of contents

| date    | topic
| ----    | ----
| week 1  | [introduction](./introduction.md)<br/>            [reproducibility](https://the-turing-way.netlify.app/welcome.html)<br/>[chatgpt](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4391863)
| week 2  | [command line](./command-line.md)
| week 3  | [project environment](./project-environment.md)<br/>[coding environment (docker)](./coding-environment.md)
| week 4  | [version control p1: working solo](./version-control.md)
| week 5  | [version control p2: collaboration](./collaboration-tools.md)
| week 6  | [data management p1: setting up a database](./data-management.md)
| week 7  | [data management p2: web api](./web-api.md)
| week 8  | [data management p3: introduction to SQL](./sql-basics.md)
| week 9  | [visualization](./visualization.md)
| week 10 | [publication p1: latex](./writing-with-latex.md)
| week 11 | [publication p2: apps](./apps.md)
| week 12 | [cloud computing](./cloud-computing.md)

## software

We will be using Slack, a command line terminal, ChatGPT, Python or R plus Jupyter (potentially with an IDE), an advanced text editor (such as Sublime Text or VS Code), SQL management software, git (potentially with dedicated software or integration into the text editor of choice), as well as LaTeX (potentially with dedicated editors).

## examination

(100\%, group assignment, same grade, deadline 11-Dec-2023, defense by 18-Dec-2023)

The exam takes the form of a little research project, hosted on Github, submitted by the deadline above and defended in person later.

Please work in groups of 2-4 people; groups must be formed and a research topic selected before the 3rd lecture starts, the only allowed change after this deadline being leaving a group or joining one if left alone. Working alone is not allowed with no exceptions; use the `#teams` channel in Slack to find a group or look for group mates.

Some further requirements are:

- the repository is called informatively: do NOT use 'DigitalToolsForFinance', 'final-project', 'DTfFSubmission' etc.; 
- the main findings are on the default branch; 
- there is an informative README file briefly describing your project, as well as the steps needed to reproduce the latter; 
- all group members are contributors to the repository and have made meaningful commits;
- the repository is structured neatly and concisely, without the clutter of folders and files for which third people have no use (use .gitignore);
- work on the project consistently, avoid bulk commits;
- keep your data transparent and easy to replace or update;
- make figures and tables in line with the visualization standards discussed in class;
- write a short text paper using LaTeX or Jupyter/Shiny, populate it with sections, a table of contents, a bibliography and the above tables and figures;
- make a beamer presentation using LaTeX;
- create an interactive app (Shiny or Jupyter notebook) describing the main findings and presenting several robustness checks;
- make the project fully reproducible: dockerize it, export the coding environment and prepare documentation; **anyone who could pass this course should be able to see and reproduce your findings from scratch**;
- have fun and feel academic-esque.

For the defense, you will be asked to help me reproduce your results **on my computer**, answering my questions down the road.

You can pick a topic from the [list of suggested topics](./research-topics.md), but own topics are strongly encouraged! You can also choose to replicate a result from a paper (which does not have an open-source implementation yet).


