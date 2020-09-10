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

The knowledge includes different topics which we will discuss in this course: version control, data management, long-distance communication and so on.


## project space
Your project lives somewhere. A good idea is to allocate a folder for all your projects and never ever leave it when starting a new one. The folder is most likely to be located on your hard drive, which we call 'local', but it is a genious idea to back it up where it cannot get deleted, which we call 'remote' or 'cloud'. Websites such as [https://github.com/](https://github.com/) or [https://www.atlassian.com/](https://www.atlassian.com/) that offer hosting for version-controlled projects (to be covered later) offer one solution for remote storage, albeit for medium-size files only &ndash; for everything else cloud drives such as Google Drive are the way to go. These have a space limit which up to a point in your research career you are not going to max out, and if it happens, you can move on to a competitor, such as `Yandex.Disk` or `Dropbox`.

So, you have allocated place for all your projects somewhere, say, folder `projects`:
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
With `projects` relocated to a different place, it is only one value, namely `$RESEARCHPATH`, that would need to be changed globally for the code to run without problems.

## software
Below is an incomplete list of software which you might have missed. We do not claim their objective superiority, but from our experience, these are what many researchers tend to gravitate to, and only few &ndash; from.

### text
*   `SublimeText` is an extensible text editor, arguably the fastest and lightest that you might encounter. Its power comes from thousands of _packages_ &ndash; extensions written to serve some purpose, e.g. provide a python engine, LaTeX language support, HTML layouts etc. Sublime is a great first choice for LaTeXing.

*   `Atom` is another extensible text editor featuring brilliant Git integration. Just like Sublime, it relies on a large set of community packages extending and enhancing its functionality. Package `hydrogen`, for instance, offers a way to learn to program in many languages by allowing for interactive coding and inline display of results. The bulk of this course is written with Atom.

### Python
*   `PyCharm` (Community edition) is what is called an integrated development environment (IDE) that consists of a million things, a customizable text editor to write code, built-in engine to run it and a debugger to, well, debug. Interestingly, the debugger serves more as a development tool for data science and econometrics, as it allows to execute code line-by-line, inspect elements and trace errors. `PyCharm` well supports coding in `R`, and its text editor can be extended to other languages as well. Convenient integration with version control systems is there too.d

### R
*   `RStudio` would be a no-brainer here, although `Atom` and `PyCharm` are becoming ever more convenient.

### Julia
Julia is a rather young language that is 'not yet there', but progressing at a decent pace. Its syntax is similar to `MATLAB` and `Python` (which makes it easy to operate), and the performance is `C`-like (close to the best there is). If you need lots of computing power and do not want/have time to optimize your code in `R`, `Python` or `MATLAB`, do give it a try.


### version control
to be discussed shortly.

### databases
to be discussed shortly.

### cloud storage
`Google Drive`, `Yandex.Disk`, `OneDrive` and `Dropbox` are decent solutions here, together offering about 45 Gb of free cloud storage space. Data protection concerns apply though: the servers where your data is copied are located where you sometimes do not want sensitive (e.g. related to a private sector job) data to appear.

### collaboration
to be discussed shortly.

## exercises
1.  install Sublime Text;
2.  install Package Control;
3.  install a package to be able to count words;
4.  create a directory for the group project you are supposed to hand in as the graded assignment for this course, then set up a basic structure for it;
5.  create an environment variable to reference the folder where all your projects, including the assignment, are.
