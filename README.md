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
| week 1 | [introduction](./introduction.md)<br/>[command line](./command-line.md)
| week 2 | [project environment](./project-environment.md)<br/>[coding environment](./coding-environment.md)
| week 3 | [version control p1: working solo](./version-control.md)
| week 4 | [version control p2: collaboration](./collaboration-tools.md)
| week 5 | [data management p1: setting up a database](./data-management.md)
| week 6 | [data management p2: web api](./web-api.md)
| week 7 | [data management p3: introduction to SQL](./sql-basics.md)
| week 8 | [visualization](./visualization.md)
| week 9 | [publication p1: latex](./writing-with-latex.md)
| week 10 | [publication p2: apps](./apps.md)
| week 11 | [reproducibility](./reproducibility.md)
| week 12 | [cloud computing](./cloud-computing.md)

## software

We will be using Slack, a command line terminal, Python or R plus jupyter (potentially with an IDE), an advanced text editor (such as Sublime Text, Atom or VS Code), SQL management software, git (potentially with dedicated software or integration into the text editor of choice), as well as LaTeX (potentially with dedicated editors).

## examination

Please work in groups of 2-4 people and set up one repository per group &ndash; this will be the place to keep the midterm and final assignments on separate branches. Groups must be formed before the 4th lecture starts, the only allowed change after this deadline being leaving one.

The repository (specifically, its main branch) must represent your final project (details below) as if it were an actual research project of yours: please, call it accordingly (not 'DigitalToolsForFinance', 'final-project' and the like) and create an informative README file briefly describing your research question and findings, as well as the steps needed to reproduce the latter.

Branch `midterm` hosts the homework, one folder per week:

```bash
|-- week1/
|   |-- ...
|-- week2/
|   |-- ...
|-- ...
```

### midterm

(25\%, group assignment, same grade)

Please do the first 6 end-of-chapter exercise sets by the beginning of the 7th lecture and push the solutions to branch `midterm`.

### final

(75\%, group assignment, same grade, deadline 19-Dec-2022)

Please submit a little research project adhering to the following requirements:

- make it hosted as a single repository on Github with all group members as contributors;
- structure it neatly and concisely, avoid the clutter of folders and files for which third people have no use (use .gitignore);
- keep working on it consistently, avoid bulk commits;
- create a little well-documented database with the data you use, ideally with update methods;
- design figures and tables to support your findings, keeping them in line with visualization standards discussed in class;
- write a short paper about it using LaTeX or Jupyter/Shiny, populating it with sections, a table of contents, as well as the above tables and figures;
- write a beamer presentation for your project using LaTeX;
- create one interactive app (Shiny or Jupyter notebook) describing the main finding and presenting several robustness checks;
- make sure the results are reproducible by ensuring that the coding environment is exported and concise documentation is present;
- in the ideal case, anyone who could pass this course should be able to see and reproduce your findings from scratch.

You can pick a topic from the [list of suggested topics](./research-topics.md), but own topics are strongly encouraged! You can also choose to replicate a result from a paper (which does not have an open-source implementation yet).
