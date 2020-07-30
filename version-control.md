# version control
## basics
In brief, a version control system is a software that allows you to take a snapshot of your project and revert to it if necessary -- just like the backup feature on an operating system or a check point in a game.

There are several version control systems around: Git, Subversion etc. -- and we will be using Git here. As stated on the [webpage](https://git-scm.com/):
> Git is a free and open source distributed version control system...

The following is based on \[[atlassian](https://www.atlassian.com/git/tutorials)\] and \[[git-book](https://git-scm.com/book/en/v2)\].

## installation
Follow the instructions on the webpage to install git. We will be mostly using the built-in git support in Atom/PyCharm/RStudio, but also take a look at the command line way to better understand what is going on under the hood.

> \[[git-book](https://git-scm.com/book/en/v2)\] The first thing you should do when you install Git is to set your user name and email address.

## usual workflow
### starting to version control
You can put a directory under version control -- and the project directory is an obvious choice! Go to your project directory and execute
```
git init
```
Now the directory is a local (existing on your machine rather than somewhere else) *repository* (virtual storage space). You can check the status of the repo anytime:
```
git status
```
Check the status after each of the following subsections!

## tracking changes
Create a file, e.g. `todo.txt` within the folder. Make it tracked (known to git):
```
git add todo.txt
```
Now you have taken a snapshot of the file and made it *staged*. You can continue to work on the file or commit the snapshot.
> \[[git-book](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)\] If you modify a file after you run `git add`, you have to run `git add` again to stage the latest version of the file.
