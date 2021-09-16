# introduction

<!-- TOC -->

- [sneaking a peak into the future](#sneaking-a-peak-into-the-future)
- [project space](#project-space)
- [software](#software)
  - [command line (aka shell, aka terminal, aka prompt)](#command-line-aka-shell-aka-terminal-aka-prompt)
  - [text](#text)
  - [coding for research](#coding-for-research)
    - [Python](#python)
    - [R](#r)
    - [Julia](#julia)
  - [econometrics](#econometrics)
  - [version control](#version-control)
  - [databases](#databases)
  - [cloud storage](#cloud-storage)
  - [collaboration](#collaboration)
- [exercises](#exercises)

<!-- /TOC -->

This course's sole purpose is to introduce an aspiring researcher to certain useful software and IT concepts which are to research what icing is to cake: not the defining part but not inessential either. After all, research is not only idea generation, data analysis and publication (which universities do a good job at teaching): there are things like project and data management, collaboration, knowledge transfer etc. which, when done properly, boost efficiency and allow to make a larger impact (yet often underrepresented in curricula). The core and heart of our little course are these little things.

Many a concept to be taught here are no big news in software development. Surprisingly(?), the latter has many similarities to research: you start with an idea, set up a team, write code, run tests, correct errors, create documentation, ensure user friendliness and publish the product: to any of these a scholar would find an analogue in own routine. The similarities ensure that knowledge transfer is possible between the two disciplines, and since the IT is the more dynamic and skin in the game-y, researchers mostly end up at the receiving end. Good for us &ndash; we can learn!

To start the transfer channel, you can go to GitHub &ndash; a place where people host all sorts of projects &ndash; to find much inspiration for one of yours. Check these out:
*   [https://github.com/CSSEGISandData/COVID-19/](https://github.com/CSSEGISandData/COVID-19/)
*   [https://github.com/bashtage/linearmodels](https://github.com/bashtage/linearmodels)
*   [https://github.com/utkuozbulak/pytorch-cnn-visualizations](https://github.com/utkuozbulak/pytorch-cnn-visualizations)


## sneaking a peak into the future
Though much of the following might still be unclear (will be clear as spring water by the end of the course), here is a good scenario for organizing research. There is one local folder e.g. `projects` where all you research projects live, one folder per project. Each project is a repository with the remote on a hosting server such as GitHub. All projects share access to a centralized database, itself a project. Each project features a more or less similar layout such as
```
~/projects/
  - project_1/
    - src/
    - text/
    - literature/
    - notes.txt
    ...
```
Each project can be cloned and its results reproduced because hard references such as `c://users//alan.smithee/...` are avoided and the coding environment is exported. LaTeX files feature a common style, itself maintained as a project.

Lots to cover!

## project space

Your project lives somewhere. A good idea is to allocate a folder for all your projects and never leave it when starting a new one. The folder will most likely to be located on your hard drive, which we call 'local', but an even better idea is to back it up where it cannot get deleted, which we call 'remote' or 'cloud'. Websites such as [https://github.com/](https://github.com/) or [https://www.atlassian.com/](https://www.atlassian.com/) that offer hosting for version-controlled projects (to be covered later) are one solution for remote storage, albeit for medium-size files only &ndash; for everything else cloud drives such as Google Drive are the way to go. These have a space limit which up to a point in your research career you are not going to max out, and if it happens, you can move on to a competitor, such as `Yandex.Disk` or `Dropbox`.

<!-- So, you have allocated place for all your projects somewhere, say, folder `projects`:
```
~/projects/
  - project_1/
  - project_2/
```
For convenience, you could set up an environment variable to reference this folder. [Environment variables](https://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them) are shortcuts which would ease transition of your projects to another machine by removing the need to rename all paths in your code. If it is unclear, consider some data import:
```python
path = "c://users/alansmithee/documents/projects/project_1/data/data.csv"
data = import_csv(path)
```
To run on the machine other than that of _alansmithee_ and his namesakes, one would need to reformat the code. Same if the `projects` folder were moved to a different location. Now consider an alternative, with environment variable `RESEARCHPATH` previously set to `c://users/alansmithee/documents/projects`:
```python
path = expand_var("$RESEARCHPATH") + "project_1/data/data.csv"
data = import_csv(path)
```
With `projects` relocated to a different place, it is only one value, namely `$RESEARCHPATH`, that would need to be changed globally for the code to run without problems. -->

## software
Below is an incomplete list of software which you might have missed. We do not claim their undisputed superiority, but from our experience, these are what many researchers tend to gravitate to, and only few &ndash; from.

### command line (aka shell, aka terminal, aka prompt)
Most of tasks you perform on a computer can be executed as commands in the black-and-white monospace-font window that is the terminal. It is a handy tool mostly used for all things files and folders and for automating tasks. Here, we will use it to perform minor file manipulations, execute git and LaTeX commands, set up a coding environment and launch jupyter notebooks.

Not that you can't perform the same tasks with your favorite programming language, but some nice cases for using the command line can be found [here](https://www.nature.com/articles/d41586-021-00263-0).

TODO: Windows/Linux stuff

### text
First, make sure you understand the difference between a text editor and word processor (refer to [the LaTeX introduction](https://github.com/ipozdeev/digital-tools-for-finance/blob/master/writing-with-latex.md#introduction) for details).

**Sublime Text** is an extensible text editor, arguably the fastest and lightest that you might encounter. Its power comes from thousands of _packages_ &ndash; extensions written to serve some purpose, e.g. provide a python engine, LaTeX language support, HTML layouts etc.

Atom is another extensible text editor featuring brilliant Git integration. Just like Sublime, it relies on a large set of community packages extending and enhancing its functionality. Package **hydrogen**, for instance, offers a way to learn to program in many languages by allowing for interactive coding and inline display of results. The bulk of this course is written with **Atom**.

### coding for research
#### Python
Python is a programming language, which we will need to run Jupyter notebooks later in the course. Please install it using the Anaconda distribution (if you care about hard drive space, feel free to use miniconda and manually install jupyter).

**PyCharm (Community edition)** is what is called an integrated development environment (IDE) that consists of a million things, a customizable text editor to write code, built-in engine to run it and a debugger to, well, debug. Interestingly, the debugger serves more as a development tool for data science and econometrics, as it allows to execute code line-by-line, inspect elements and trace errors. **PyCharm** well supports coding in R, and its text editor can be extended to other languages as well. Convenient integration with version control systems is there too.

#### R
**RStudio** would be a no-brainer here, although **Atom** and **PyCharm** are becoming ever more convenient.

#### Julia
**Julia** is a rather young language that is 'not yet there', but progressing at a decent pace. Its syntax is similar to MATLAB and Python (which makes it easy to operate), and the performance is C-like (close to the best there is). If you need lots of computing power and do not want/have time to optimize your code in R, Python or MATLAB, do give it a try.

### econometrics
**gretl** is a free and rather powerful open-source alternative to **EViews** and **Stata**, perfectly balanced for peek-in estimations and more advanced projects.

### version control
We will be using Git, which you should install from [here](https://git-scm.com/downloads). Please also create an account on [Github](https://github.com/).

### databases
We will be using MySQL. An installation guide for Windows can be found [here](https://youtu.be/7S_tz1z_5bA?t=593). The same video also contains instructions for a Mac installation.

### cloud storage
**Google Drive**, **Yandex.Disk**, **OneDrive** and **Dropbox** are decent solutions here, together offering about 45 Gb of free cloud storage space. Data protection concerns apply though: the servers where your data is copied are located where you sometimes do not want sensitive (e.g. related to a private sector job) data to appear.

### collaboration
We will be using **Slack**, **Zoom** and **Miro** (you can install all three locally or use from the browser). Please create an account with each of those or connect an existing one.

## exercises
1.  install Sublime Text;
2.  install Package Control;
3.  install a package to be able to count words;
4.  install package 'Terminus' used to open a terminal right in the editor;
4.  create a directory for the group project you are supposed to hand in as the graded assignment for this course, then set up a basic structure for it;
6.  install git and create an account on GitHub;
6.  create an account on **Slack** and join the `DTfF` group (invite will be sent per email);
7.  create an account on **Miro**;
8.  install python using anaconda or miniconda and make sure `jupyter` is installed;
9.  (optional) if unhappy with python, install R or julia.
