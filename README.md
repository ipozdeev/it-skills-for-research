Technical skills for academic (not only) research, may be a bit finance-centric.


# prerequisites
*   intermediate knowledge of Python or R: how to write a function, plot a chart, format string values, read to and write from text files etc.; 
*   previous exposure to research projects.


# table of contents
| date    | topic
| ----    | ----
| week 1 | [introduction](./introduction.md)<br/>software<br/>[project management](./project-environment.md)
| week 2 | [command line](./command-line.md)
| week 3 | [version control p1: working solo](./version-control.md)
| week 4 | [version control p2: collaboration](./collaboration-tools.md)
| week 5 | [latex p1: setup and basic usage](./writing-with-latex.md)
| week 6 | [latex p2: advanced topics](./writing-with-latex.md)
| week 7 | [data management p1: setting up a database](./data-management.md)
| week 8 | [data management p2: web api](./data-management.md)
| week 9 | [data management p3: introduction to SQL](./data-management.md)
| week 10 | [visualization](./visualization.md)
| week 11 | [knowledge transfer](./knowledge-transfer.md)
| week 12 | reproducibility


# software
We will be using Slack, a command line terminal, Python or R plus jupyter (potentially with an IDE), an advanced text editor (such as Sublime Text, Atom or VS Code), SQL management software, git (potentially with dedicated software or integration into the text editor of choice), as well as LaTeX (potentially with dedicated editors).


# examination
Please work in groups of 2-4 people and set up one repository per group -- this will be the place to keep the midterm and final assignments on separate branches. Groups must be formed before the 4th lecture starts, the only allowed change after this deadline being leaving one.

## midterm

(25\%, group assignment, same grade)

Please do the first 6 end-of-chapter exercise sets by the beginning of the 7th lecture and push the solutions to branch `midterm`.

## final

(75\%, group assignment, same grade)

Please submit a little research project adhering to the following requirements:

*   make it hosted as a single repository on Github with all group members as contributors;
*   structure it neatly and concisely, avoid the clutter of folders and files for which third people have no use (use .gitignore);
*   keep working on it consistently, avoid bulk commits;
*   create a little well-documented database with the data you use, featuring possibility to update it with fresh values;
*   design figures and tables to support your findings, keeping them in line with visualization standards discussed in class;;
*   write a short paper about it using LaTeX, populating it with sections, a table of contents, as well as the above tables and figures;
*   write a beamer presentation for your project using LaTeX;
*   create one interactive app (R shiny or jupyter notebook) describing the main finding and presenting several robustness checks;
*   make sure the results are reproducible by ensuring that the coding environment is exported and concise documentation is present.