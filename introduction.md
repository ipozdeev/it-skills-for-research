# introduction

- [introduction](#introduction)
  - [sneaking a peak into the future](#sneaking-a-peak-into-the-future)
  - [software](#software)
    - [command line](#command-line)
    - [text](#text)
    - [coding](#coding)
    - [version control](#version-control)
    - [databases](#databases)
    - [cloud storage](#cloud-storage)
    - [collaboration](#collaboration)
  - [todos](#todos)

This course's sole purpose is to introduce an aspiring researcher to certain useful software and IT concepts which are to research what icing is to cake: not the defining part but not inessential either. After all, research is not only idea generation, data analysis and publication (which universities do a good job at teaching): there are elements such as project and data management, collaboration, knowledge transfer etc. (which are often underrepresented in curricula). Addressing these elements properly boosts the researcher's efficiency and the impact of the end product. This is exactly what we will try to learn in the following weeks.

Many a concept to be taught here are no big news in software development. Surprisingly(?), the latter has many similarities to research: you start with an idea, set up a team, write code, run tests, correct errors, create documentation, ensure user friendliness and publish the product: to any of these a scholar would find an analogue in own routine. The similarities ensure that knowledge transfer is possible between the two disciplines, and since the IT is the more dynamic and skin in the game-y, researchers mostly end up at the receiving end. Good for us &ndash; we can learn!

To start the transfer channel, you can go to GitHub &ndash; a place where people host all sorts of projects &ndash; to find much inspiration for one of yours. Check these out:

- [https://github.com/CSSEGISandData/COVID-19/](https://github.com/CSSEGISandData/COVID-19/)
- [https://github.com/karpathy/cryptos](https://github.com/karpathy/cryptos)
- [https://github.com/bashtage/linearmodels](https://github.com/bashtage/linearmodels)
- [https://github.com/utkuozbulak/pytorch-cnn-visualizations](https://github.com/utkuozbulak/pytorch-cnn-visualizations)

## sneaking a peak into the future

Though much of the following might still be unclear (will be clear as spring water by the end of the course), here is a good scenario for organizing research. There is one local folder e.g. `projects` where all you research projects live, one folder per project. Each project is a repository with the remote on a hosting server such as GitHub. All projects share access to a centralized database, itself a project. Each project features a more or less similar layout such as

```bash
|-- projects/
|   |-- project_1/
|   |   |-- src/
|   |   |-- text/
|   |   |-- literature/
|   |   |-- notes.txt
|   |   |-- ...
```

Each project can be cloned and its results reproduced because hard references such as `c://users//alan.smithee/...` are avoided and the coding environment is exported. LaTeX files feature a common style, itself maintained as a project.

Lots to cover!

## software

Below is on overview of what we will encounter in this course.

### command line

The developer's workhorse. There are some non-essential differences between Windows and Linux/Mac.

### text

**Sublime Text**, **Atom**, **VS Code** or integrated development environments: **PyCharm**, **Spyder**, **RStudio** and the like &ndash; are all good choices.

### coding

**Python**, **R** or **Julia**, maybe in the form of jupyter notebooks.

### version control

**Git**. Please also create an account on [Github](https://github.com/).

### databases

**PostgreSQL** and maybe language-specific database libraries.

### cloud storage

Google Drive, OneDrive and Dropbox are decent solutions here, together offering about 45 Gb of free cloud storage space. Data protection concerns apply though: the servers where your data is copied are located where you sometimes do not want sensitive (e.g. related to a private sector job) data to appear.

### collaboration

**Slack**, **Zoom** and **Miro** (you can install all three locally or use from the browser). Please create an account with each of those or connect an existing one.

## todos

1. create an account on **Slack** and join the `isfr-2022` group (invite will be sent per email).
2. install a text editor of choice;
3. create an account on GitHub.
