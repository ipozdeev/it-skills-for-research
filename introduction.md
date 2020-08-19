# introduction

Most of research project feature a similar set of integral parts. First, there is an idea. Then, there are soliloquies or discussions about it resulting in its development and fruition. There is data and code to transform the data into results: remarks, tables, figures. There is text which you use to communicate your results to an audience. With that being said, it is possible to write down a generic layout of a research project like this:
```
/project
- data/
- text/
- src/
- tmp/
- notes.txt
```
This is it, really! With non-essential modifications, most research projects have a structure as above, and indeed, if you go to GitHub &ndash; a place where people host their projects, not necessarily research-related &ndash; you might find that all sorts of projects maintained by people with skin in the project game have a similar structure! Check these out:
*   [https://github.com/CSSEGISandData/COVID-19/](https://github.com/CSSEGISandData/COVID-19/)
*   [https://github.com/bashtage/linearmodels](https://github.com/bashtage/linearmodels)
*   [https://github.com/utkuozbulak/pytorch-cnn-visualizations](https://github.com/utkuozbulak/pytorch-cnn-visualizations)

This means that a research project is pretty much kin to development projects one sees on GitHub, and that knowledge transfer is possible.

The knowledge includes different topics which we will discuss in this course: version control, data management, outward communication and so on.


## project space
Your project lives somewhere. A good idea is to allocate a folder for all your projects and never ever leave it when starting a new one. The folder is most likely to be located on your hard drive, which we call 'local', but it is a genious idea to back it up where it cannot get deleted, which we call 'remote' or 'cloud'. Version control systems to be covered later offer &ndash; as a side effect, really &ndash; one solution for remote storage, but for medium-size files only; for everything else cloud drives such as Google Drive are the way to go. These have a space limit which up to a point in your research career you are not going to max out, and if it happens, you can move on to a competitor, such as Yandex.Disk or Dropbox.

So, you have allocated place for all your projects somewhere, say, folder `projects`:
```
~/projects/
  - project_1/
  - project_2/
```
For convenience, you could set up an environment variable to reference this folder. [Environment variables](https://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them) are shortcuts which would ease transition of your projects to another machine by removing the need to rename all paths in your code. If it is unclear, consider some data import:
```python
path = "c://users/ipozdeev/documents/projects/project_1/data/data.csv"
data = import_csv(path)
```
To run on the machine other than that of _ipozdeev_ and his namesakes, one would need to reformat code. Now consider this, with environment variable `RESEARCHPATH` previously  set to `c://users/ipozdeev/documents/projects`:
```python
path = expand_var("$RESEARCHPATH") + "project_1/data/data.csv"
data = import_csv(path)
```

## software
Below is a screamingly incomplete list of software which you might have missed &ndash; potentially regretfully, since a lot of it have from our experience been what many migrate to and few from.

### text
*   SublimeText is an extensible text editor, arguably the fastest and lightest of all. Its functionality and power comes from thousands of *packages* &ndash; extensions written to serve a purpose, e.g. provide a python engine, LaTeX language support, HTML layouts etc. Sublime is a great first choice for LaTeXing.

*   Atom is another extensible text editor featuring brilliant Git integration. Just like Sublime, it relies on a large set of community packages extending and enhancing it. Package `hydrogen`, for instance, offers a fantastic way to learn to code in many languages by allowing for interactive coding and inline display of results. The bulk of this course was written using Atom.

### Python
*   PyCharm (Community edition) is what is called an integrated development environment (IDE) that consists of a customizable text editor to write code, TODO:what? to run it and a built-in debugger to, well, debug. Interestingly, the debugger serves more as a development tool for data science and econometrics, as it allows to run code line-by-line, inspect elements and trace errors. PyCharm well supports coding in R, and its text editor can be extended to other languages as well. Convenient integration with version control systems is there too.

### R
*   RStudio would be a no-brainer here, although Atom and PyCharm are becoming ever more convenient.

### version control
to be discussed shortly.

### databases
to be discussed shortly.

### cloud storage
Google Drive, Yandex.Disk and Dropbox are decent solutions here, together offeing about 40 Gb of free cloud storage space.

### collaboration
to be discussed shortly.
