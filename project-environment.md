# project environment

- [project environment](#project-environment)
  - [project file tree](#project-file-tree)
  - [text editor](#text-editor)
  - [coding](#coding)
    - [inline/on-demand execution](#inlineon-demand-execution)
    - [scripting](#scripting)
    - [coding environment](#coding-environment)
  - [environment variables](#environment-variables)
    - [referencing paths](#referencing-paths)
    - [storing credentials](#storing-credentials)
  - [version control system](#version-control-system)
  - [database](#database)
  - [resources](#resources)
  - [exercises](#exercises)

A project environment is everything that makes your project work. Borrowing from IT again, it is comprised by (bar some modifications):

- project file tree;
- text editor;
- code interpreter;
- environment variables;
- version control system;
- database.

## project file tree

Your project lives somewhere. A good idea is to allocate a folder for all your projects and never leave it when starting a new one. The folder will most likely be located on your hard drive, which we call 'local', but an even better idea is to back it up where it cannot get deleted, which we call 'remote'. Websites such as [https://github.com/](https://github.com/) or [https://www.atlassian.com/](https://www.atlassian.com/) that offer hosting for version-controlled projects (to be covered later) are one solution for remote storage, albeit for medium-size files only &ndash; for everything else cloud drives such as **Google Drive** are the way to go. These have a space limit which up to a point in your research career you are not going to max out, and if it happens, you can move on to a competitor, such as Dropbox.

The importance of having a logical, tidy and, most importantly, consistent and appropriate project tree cannot be stressed enough: it fosters comprehensibility and reproducibility and boost efficiency. A tidy project tree makes it easy to navigate through the project: data is located in folder `data/`, and code in folder `src/`, and folder `text/figures` contains the figures to be used in your reports. A consistent project tree saves you time (no need to think how to structure a new project!) and makes it easier for other people to follow your research. An appropriate project tree &ndash; the one that is consistent across projects and researchers &ndash; is an important pillar of reproducibility.

The [`cookiecutter`](https://cookiecutter.readthedocs.io/en/latest/overview.html) project was started to tackle the above considerations; its [data science layout](http://drivendata.github.io/cookiecutter-data-science/) is a great fit for this course, so take your time to explore it.

## text editor

*NB: Make sure you understand the difference between a text editor and word processor (refer to [the LaTeX introduction](https://github.com/ipozdeev/digital-tools-for-finance/blob/master/writing-with-latex.md#introduction) for details).*

**Visual Studio Code** and **Sublime Text** are some popular choices. These are extensible text editors with thousands of *packages* written to serve all kinds of purposes, e.g. to provide a Python engine, LaTeX language support, in-editor access to the terminal etc.

Integrated development environments (IDE) such as **Spyder**, **RStudio** and **PyCharm** is a convenient alternative to a basic text editor. An IDE combines the basic text editor functionality with that of a code interpreter, version control and testing system, a debugger etc. and is essentially text editor on steroids.

## coding

The most frequently used free programming languages are **Python** and **R**, as well as the ambitious up-and-comer **Julia**. Each language has own pros and contras (duh), and it might be a good idea to learn all three at some point: this way you would be able to utilize the multifunctionality of Python, computational power of Julia and R Shiny apps for visualization of results all in one project.

Be it Python, R or Julia, there are several ways to use them:

- running code inline/on-demand: for learning, quick calculations,knowledge transfer and presentations;
  - Jupyter notebooks as a notable example;
- scripting: for optimizing code, remote computing and code sharing.

A way to have the best of the two worlds is the debugger mode in an IDE such as PyCharm.

### inline/on-demand execution

A quick and easy way to code and check the results on-the-fly is to use language-specific REPLs (one would pop up after executing `python` from the command line), Jupyter notebooks (to be covered later in the corresponding section), as well as the debugger mode in an IDE such as [PyCharm](https://www.jetbrains.com/pycharm/).

### scripting

The more advanced and powerful way to code is to write scripts in any text editor and execute them in a shell. As an example, let there be file `figure-1.py` with the following content:

```python
import matplotlib.pyplot as plt

plt.plot([1, 2], [1, 4])
plt.show()
```

Then, to run it with Python, execute the following in the command line:

```bash
python figure-1.py
```

to see the output.

### coding environment

The configuration of the code interpreter, especially the information about the used packages, constitutes the coding environment. It is an absolute must to know and record this information, as shareability of code and reproducibility of results hinge it being done properly. This is a huge topic in itself and to be discussed separately in a later section.

## environment variables

Environment variables are key-value pairs in the project environment, most commonly used where values are subject to frequent change. Two most common use cases are referencing paths and storing credentials.

Since your code depends on the environment variables just as on the interpreter, you would have to specify which variables must be set in the project description.

### referencing paths

The most famous environment variable is of course `PATH` that references all the locations the system searches for instructions when a command is executed. Unless a script called `julia` can be found among the places stipulated in `PATH`, it is useless to try to call `julia` in a shell.

On a related note, consider some data import:

```python
path = "c://users/alan.smithee/documents/projects/project-1/data/data.csv"
data = import_csv(path)
```

To run this code on a machine other than that of *alan.smithee*, you would need to reformat the code; same if the `projects` folder were moved to a different location. Now consider an alternative, with environment variable `RESEARCH_PATH` previously set to `c://users/alan.smithee/documents/projects`:

```python
path = expand_var("$RESEARCH_PATH") + "project_1/data/data.csv"
data = import_csv(path)
```

With `projects` relocated to a different place, it is only one value, namely `RESEARCH_PATH`, that would need to be changed globally for the code to run without problems.

### storing credentials

When working with logins and passwords, e.g. connecting to a database or using an API, you should of course not keep passwords in the code files (nor upload them to GitHub!). An alternative to

```python
username = "alan.smithee"
password = "BYEYxtAJ9~s>qU2%"

data = get_data_from_db(username=username, password=password)
```

would be to create environment variables `DB_USERNAME` and `DB_PASSWORD` and write:

```python
data = get_data_from_db(username=expand_var("$DB_USERNAME"),
                        password=expand_var("$DB_PASSWORD"))
```

## version control system

Version control systems, or VCS, have become a must in IT and must become such in research. Skipping ahead to the next lecture, a VCS is
> [...] not unlike the backup feature of an operating system or checkpoints in a computer game [...]

yet way more powerful. If the existence of this course were to be justified by one topic, version control would easily be it.

## database

This is the research-specific, and not borrowed from IT, part of the environment. Since data is such a big deal in empirical research, investments into organizing it *comme il faut* pay off quickly. We will discuss the best practices and some examples down the road.

## resources

- [cookiecutter](https://cookiecutter.readthedocs.io/en/latest/overview.html);
- [gretl](http://gretl.sourceforge.net/) is a free powerful open-source alternative to **EViews** and **Stata**, perfectly balanced for peek-in estimations and more advanced projects;
- [python-dotenv](https://pypi.org/project/python-dotenv/) is a handy tools for managing environment variables in Python.

## exercises

1. install a nice text editor;
2. install Python (best with anaconda or miniconda) and make sure you can run `pip` or `conda` from the command line;
3. install `cookiecutter`;
4. create a directory for the group project you are supposed to hand in as the graded assignment for this course and set up a basic structure for it (best by using cookiecutter and trimming unnecessary stuff);
5. create an environment variable `RESEARCH_PATH` (don't forget about the platform-specific '&' and '%') referencing the folder with all your projects;
6. (optional) if unhappy with Python, install R or Julia or anything of your choice;
7. install git and create an account on GitHub;
8. make sure you can run `git` from the command line (on Windows, you can install **git bash** to emulate the terminal for git-related commands).
