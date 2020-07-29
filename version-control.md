## version control
### basics
In brief, a version control system is a software that allows you to take a snapshot of your project and revert to it if necessary -- just like the backup feature on an operating system or a check point in a game.

There are several version control systems around: Git, Subversion etc. -- and we will be using Git here. As stated on the [webpage](https://git-scm.com/):
> Git is a free and open source distributed version control system...

The following is closely based on [https://www.atlassian.com/git/tutorials](https://www.atlassian.com/git/tutorials).

### installation
Follow the instructions on the webpage to install git. We will be mostly using the built-in git support in Atom/PyCharm/RStudio, but also take a look at the command line way to better understand what is going on under the hood.

### starting to version control
You can put a directory under version control -- and the project directory is an obvious choice! Go to your project directory and execute
```
git init
```
Now the directory is a local (existing on your machine rather than somewhere else) *repository* (virtual storage space). Every change to it is now recorded!

### saving changes
Create a file. Add it to the  
