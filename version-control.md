# version control
<!-- TOC -->

-   [basics](#basics)
-   [installation](#installation)
-   [starting to version control](#starting-to-version-control)
-   [tracking changes](#tracking-changes)
-   [publishing changes](#publishing-changes)
-   [fixing the screwed-up](#fixing-the-screwed-up)
    -   [1. roll back changes in a file](#1-roll-back-changes-in-a-file)
    -   [2. roll back changes in repo](#2-roll-back-changes-in-repo)
    -   [3. roll back changes via a new commit](#3-roll-back-changes-via-a-new-commit)
-   [ignoring files](#ignoring-files)
-   [resources](#resources)
-   [exercises](#exercises)

<!-- /TOC -->

## basics
In brief, a version control system is a software that allows you to take a snapshot of your project and revert to it if necessary &mdash; just like the backup feature on an operating system or a checkpoint in a game. Version control is great for all things text: first and foremost code, but also dissertations, memos and reports. Plus, on an equally important note, it facilitates concurrent editing and allows groups of people to efficiently work on the same set of files.

There are several version control systems around: Git, Subversion etc. &mdash; and we will be using Git here. As stated on the [webpage](https://git-scm.com/):
> Git is a free and open source distributed version control system...

Here, *free* means you do not have to pay for it; *open source* &ndash; that the code behind it is not proprietary (you can download, customize and amend it); *distributed* &ndash; [this](https://www.atlassian.com/blog/software-teams/version-control-centralized-dvcs).

The following is based on \[[atlassian](https://www.atlassian.com/git/tutorials)\] and \[[git-book](https://git-scm.com/book/en/v2)\].

## installation
Follow the instructions on the webpage to install git. We will be mostly using the built-in git support in Atom/PyCharm/RStudio, but also take a look at the command line way to better understand what is going on under the hood.

> \[[git-book](https://git-scm.com/book/en/v2)\] The first thing you should do when you install Git is to set your user name and email address.

## starting to version control
You can put a directory under version control &mdash; and the project directory is an obvious choice! Go to the directory associated with your project (not the one with all the projects!) and execute
```
git init
```
Now the directory is a local (existing on your machine rather than somewhere else) *repository* (virtual storage space). If you want to share your project (or just make it accessible from everywhere), you would have to find a *remote* place to store your repository. Places like [https://www.atlassian.com/](atlassian.com) and [https://github.com/](github.com) offer this possibility (but you could also set it up on an own server). Once you have an account, you can create a remote repository and point your local repository to it.
```
git remote add <shortname> <url>
```
Alternatively, you can create an empty remote on Github first, then _clone_ it to the local machine:
```
git clone <url>
```

You can check the status of the repo anytime:
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

To commit means to persist changes in the repository. The repo can then be reverted back to any committed version. You can think of this similar to the multiverse theory: with each commit, the universe of your project branches, so that if you are unhappy with a branch you are perching on, you can go back to where the branch originated and take a parallel branch. Do not ignore the commit message &mdash; these make it easier to navigate in the change history!
```
git commit -m "initial commit of todo"
```
[Here](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) are some best practices for git messages. You can look up the history of commits:
```
git log --oneline
```
## publishing changes
Having committed stuff, it is time to *push* it to the remote repo thus making the changes public. Anyone with access to the remote repo will be able to integrate the changes into their own working copy.
```
git push
```

## fixing the screwed-up
The following describes three cases which I have encountered the most. All other cases are left for you to explore on demand.

### 1. roll back changes in a file
Reason: one file is doomed, let me discard all changes, committed or not, staged or not, and just make the file match a previous commit:
```
git checkout <SHA> <filename>
```

### 2. roll back changes in repo
Reason: everything since a previous commit is ugly and I do not want to see it anymore.

You can undo changes that haven’t been shared with anyone else using
```
git reset <SHA> --hard
```
Make sure you **really** mean it though, as your repo will be updated to match the specified commit and all staged and unstaged changes will be lost.

### 3. roll back changes via a new commit
Reason: A previous commit was faulty, and I want to undo those changes, but keep the shameful history.

You can undo all changes in a commit using:
```
git revert <SHA>
```
This is kind of applying the inverse of a commit from your project history. Let the `<SHA>` of the commit you do not like be `sha_1`. If you run `git revert <sha_1>`, a new commit is made with a new `<SHA>`, let it read `<sha_2>`. Now, if you run `git revert <sha_2>`, the repo is back to where you started before running the first revert.

Unlike `git reset`, this command adds a new commit that restores the tree to some previous state instead of clipping the tree. This is both safer and easier to work with, especially if you previously pushed your commit and others cloned it. In general, **never use `git reset` when changes have been pushed to a public repository and other people rely on them**.

## ignoring files
Some files and folders do not need to be tracked, for instance, temporary files, large data containers (a .csv file with stock price history), auxiliary files such as LaTeX's .aux and .fft, project-specific software settings etc. To exclude those, you create file called `.gitignore` in your repo and fill it with relative or absolute paths to files and folder that you want to exclude from version control. Some examples:

path | purpose
--- | ---
`data/`  |  folder **data/**
`data/*` <br> `!data/description.txt` | everything in folder **data/** except file **description.txt**
`*.log` | files with extension '**.log**'

Note however that
> git will continue to track any files that are already being tracked.

To stop the file from being tracked, see [this answer](https://stackoverflow.com/questions/1274057/how-to-make-git-forget-about-a-file-that-was-tracked-but-is-now-in-gitignore).

## resources
*   [difference between `checkout`, `reset` and `revert`](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting);
*   [lots of useful path examples for .gitignore](https://www.atlassian.com/git/tutorials/saving-changes/gitignore);
*   [lots of useful templates of `.gitignore` files](https://github.com/github/gitignore).


## exercises
1.  Install Git;
2.  Create an account on Github (or use an existing if you want);
3.  Set up a local repository;
4.  Within it, create the following two folder and two files:

```
data/
text/
notes.txt
functions.py
```

and exclude folder `data/` from being tracked;
5.  Add and commit everything;
6.  Add line reading 'THIS IS FINE' to `notes.txt`, commit the new version with message 'a fine change';
7.  Change that line to 'THIS IS GOOD', commit the new version with message 'a good change' _overwriting the previous commit_ as if it never happened (make sure `git log` does not show 'a fine change');
8.  Change that line to 'THIS IS BAD' and close the editor to make it impossible to use `Ctrl+Z`;
9.  Try to restore `notes.txt` to the state where it reads 'THIS IS GOOD';
10. Change that line to 'THIS IS THE BEST' and delete file `functions.py`, commit your changes giving your commit a name such as 'first-working';
11. Undo the previous commit using `git revert`, makes sure `functions.py` does exist and the line reads 'THIS IS GOOD';
8.  Create a remote repo on Github/Bitbucket and link your local repo to it;
9.  Push all the commits to the remote;
10. Try to revert the repo to the state where `notes.txt` read 'THIS IS FINE'.
11. Commit and push all the commits to the remote.
