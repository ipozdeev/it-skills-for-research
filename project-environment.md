# project environment

<!-- TOC -->

- [project environment](#project-environment)
  - [project file tree](#project-file-tree)
  - [text editor](#text-editor)
  - [coding](#coding)
    - [scripting](#scripting)
    - [ipython notebooks](#ipython-notebooks)
    - [IDE](#ide)
  - [version controls system](#version-controls-system)
  - [database](#database)
  - [environment variables](#environment-variables)
  - [resources](#resources)
  - [exercises](#exercises)

<!-- /TOC -->

A project environment is everything that makes your project work. Again borrowing heavily from IT, it is comprised by (bar some modifications):
* project file tree;
* text editor;
* code interpreter/compiler;
* version control system;
* database.


## project file tree

Your project lives somewhere. A good idea is to allocate a folder for all your projects and never leave it when starting a new one. The folder will most likely be located on your hard drive, which we call 'local', but an even better idea is to back it up where it cannot get deleted, which we call 'remote' or 'cloud'. Websites such as [https://github.com/](https://github.com/) or [https://www.atlassian.com/](https://www.atlassian.com/) that offer hosting for version-controlled projects (to be covered later) are one solution for remote storage, albeit for medium-size files only &ndash; for everything else cloud drives such as Google Drive are the way to go. These have a space limit which up to a point in your research career you are not going to max out, and if it happens, you can move on to a competitor, such as `Yandex.Disk` or `Dropbox`.


## text editor
*NB: Make sure you understand the difference between a text editor and word processor (refer to [the LaTeX introduction](https://github.com/ipozdeev/digital-tools-for-finance/blob/master/writing-with-latex.md#introduction) for details).*

**Sublime Text** is an extensible text editor, arguably the fastest and lightest that you might encounter. Its power comes from thousands of _packages_ &ndash; extensions written to serve some purpose, e.g. provide a Python engine, LaTeX language support, HTML layouts etc.

**Atom** is another extensible text editor featuring brilliant Git integration. Just like Sublime, it relies on a large set of community packages extending and enhancing its functionality. Package **hydrogen**, for instance, offers a way to learn to program in many languages by allowing for interactive coding and inline display of results. The bulk of this course is written with **Atom**.

An integrated development environment (IDE) such as **Spyder**, **RStudio** and **PyCharm** is a convenient alternative to a basic text editor, combining the basic text functionality with that of a code interpreter, version control and testing system, a debugger etc.

## coding
The most frequently used free programming languages are Python, R and Julia. Each has own pros and contras (duh).

If you haven't heard about **Julia**, it is is a rather young language developed at MIT that is 'not yet there', but progressing at a decent pace. Its syntax is similar to MATLAB and Python (which makes it easy to operate), and the performance is C-like (close to the best there is). If you need lots of computing power and do not want/have time to optimize your code in R, Python or MATLAB, do give it a try.

Be it Python, R or Julia, there are several possibilities to use it for research:
* scripting: for advanced users;
* jupyter notebooks: for quick calculations/code sharing/presentations;
* IDE: for intermediate users (dominates scripting);

### scripting
The first is to write scripts of code in any text editor and execute them in a shell. Let there be file `figure-1.py` with the following content:
```python
import matplotlib.pyplot as plt

plt.plot([1, 2], [1, 4])
plt.show()
```
Then, to interpret it with Python, execute the following in the command line:
```bash
python figure-1.py
```
to see the output.


### ipython notebooks
Another is to use IPython notebooks, which we will cover in a later section. You would need to install Python first, together with library `jupyter`, so please do so using the Anaconda distribution (if you care about hard drive space, feel free to use miniconda and manually install jupyter). The number of languages you can use (what is called 'as kernels') in a jupyter notebook is [impressive](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels).


### IDE
Yet another is to use an IDE (see above) or a simpler coding environment such as Atom's `hydrogen` package.


## version controls system
A VCS has become a must in IT and must become a must in research. Skipping ahead to the next lecture, a VCS is
> [...] not unlike the backup feature of an operating system or checkpoints in a computer game [...]

yet way more powerful. If the existence of this course were to be justified by one topic, version control would be the obvious choice.


## database
This is the research-specific, and not borrowed from IT, part of the environment. Since data is such a big deal in empirical research, investments into organizing it *comme il faut* pay off quickly. We will discuss the best practices and some examples down the road.


## environment variables

How does one part of the project environment know about the others, e.g. how does the code know how to connect to the database or where does your IDE take the version control credentials from? The stuff that allows parts of the environment talk to each other are environment variables, and there are two and a half most common use cases for them: **PATH** variable, referencing paths and storing passwords.

> [What are PATH and other environment variables, and how can I set or use them?](https://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them)

You can define an environment variable to avoid those problems when someone cannot run your code because they are not your full namesake. Consider some data import:
```python
path = "c://users/alan.smithee/documents/projects/project-1/data/data.csv"
data = import_csv(path)
```
To run on the machine other than that of _alan.smithee_ one would need to reformat the code. Same if the `projects` folder were moved to a different location. Now consider an alternative, with environment variable `RESEARCH_PATH` previously set to `c://users/alan.smithee/documents/projects`:
```python
path = expand_var("$RESEARCHPATH") + "project_1/data/data.csv"
data = import_csv(path)
```
With `projects` relocated to a different place, it is only one value, namely `$RESEARCHPATH`, that would need to be changed globally for the code to run without problems.

Also, when working with logins and passwords, e.g. connecting to a database or using an API, you should of course not keep passwords in the code files (nor upload them to github!). An alternative to
```python
username = "alan.smithee"
password = "BYEYxtAJ9~s>qU2%"

data = get_data_from_db(username=username, password=password)
```
would be to create environment variables "$DB_USERNAME" and "$DB_PASSWORD" and write:
```python
data = get_data_from_db(username=expand_var("$DB_USERNAME"),
                        password=expand_var("$DB_PASSWORD"))
```


## resources
* [gretl](http://gretl.sourceforge.net/) is a free powerful open-source alternative to **EViews** and **Stata**, perfectly balanced for peek-in estimations and more advanced projects.


## exercises
1.  install Sublime Text;
2.  install Package Control;
3.  install a package to be able to count words and package 'Terminus' used to open a terminal within the editor;
4.  create a directory for the group project you are supposed to hand in as the graded assignment for this course, then set up a basic structure for it;
5.  create an environment variable RESEARCH_PATH (don't forget about the platform-specific '&' and '%') referencing the folder with all your projects;
6.  write a script that, when executed, would create a new directory of a given name in the folder above folder, referencing the latter with the created environment variable (make sure the script runs on any machine subject to the environment variable being set), and put the script in the directory you created in task 4;
7.  install Python using anaconda or miniconda and make sure `jupyter` is installed;
8.  (optional) if unhappy with Python, install R or Julia;
9.  (very optional) if unhappy with all of the above, install something else;
10.  install git and create an account on GitHub;
