# introduction

Most of research projects feature a similar set of constituent parts. First, there is an idea. Then, there are soliloquies or discussions about it resulting in its development and fruition. There is data, there is statistics and code to transform the data into results: remarks, tables, figures. There is text and speech which you use to communicate your results to an audience. There is feedback and publication. With that being said, it is possible to write down a generic layout of a research project like this:
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
Your project lives somewhere. A good idea is to allocate a folder for all your projects and never ever leave it when starting a new one. The folder is most likely to be located on your hard drive, which we call 'local', but it is a genius idea to back it up where it cannot get deleted, which we call 'remote' or 'cloud'. Version control systems to be covered later offer &ndash; as a side effect, really &ndash; one solution for remote storage, but for medium-size files only; for everything else cloud drives such as Google Drive are the way to go. These have a space limit which up to a point in your research career you are not going to max out, and if it happens, you can move on to a competitor, such as Yandex.Disk or Dropbox.

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
Just in case you missed any of these, we highly encourage you give them a try.

purpose  |  tool
--|--
python  |  PyCharm (Community edition)
R  |  RStudio
text  |  SublimeText <br>  Atom
version control  |  Git
databases  |  MySQL
cloud storage  |  Google Drive <br> Dropbox <br> Yandex.Disk
collaboration  |  Slack <br> Zoom
