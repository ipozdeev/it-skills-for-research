# version control
<!-- TOC -->

- [basics](#basics)
- [installation](#installation)
- [starting to version control](#starting-to-version-control)
- [git areas](#git-areas)
- [tracking changes](#tracking-changes)
- [fixing the screwed-up](#fixing-the-screwed-up)
  - [1. roll back recent changes](#1-roll-back-recent-changes)
  - [2. go back to a particular commit](#2-go-back-to-a-particular-commit)
  - [3. roll back all changes](#3-roll-back-all-changes)
  - [4. roll back changes via a new commit](#4-roll-back-changes-via-a-new-commit)
- [ignoring files](#ignoring-files)
- [publishing changes](#publishing-changes)
- [resources](#resources)
- [exercises](#exercises)

<!-- /TOC -->

## basics
A version control system is a software that keeps track of the files you are working on, recording introduced modifications and allowing to recall and undo them &ndash; not unlike the backup feature of an operating system or checkpoints in a computer game. It also facilitates concurrent editing and allows groups of people to efficiently work on the same set of files without running into conflicts. Version control is great for all things text: first and foremost code (where it is becoming a must), but also dissertations, memos and reports.

There are several version control systems around such as Git and Subversion; we will be using Git here. As stated on the [webpage](https://git-scm.com/):
> Git is a free and open source distributed version control system...

Here, *free* means you do not have to pay for it; *open source* &ndash; that the code behind it is not proprietary (you can download, customize and amend it); *distributed* &ndash; [this](https://www.atlassian.com/blog/software-teams/version-control-centralized-dvcs).

The following is based on \[[atlassian](https://www.atlassian.com/git/tutorials)\] and \[[git-book](https://git-scm.com/book/en/v2)\].

## installation
Follow the instructions on the webpage to install Git. Now, to operate Git you can:
*   enter commands in the command line;
*   rely on your favorite text editor's built-in Git integration;
*   use a specialized third software such as Sublime Merge.
Choose whatever you like! In this tutorial, we will stick to the first option. Obviously, the same commands we will be executing power the Git features of your favorite text editor or third software.

> \[[git-book](https://git-scm.com/book/en/v2)\] The first thing you should do when you install Git is to set your user name and email address.

## starting to version control
You can put a directory under version control &mdash; and the project directory is an obvious choice! Go to the directory associated with the project you would like to start tracking and execute
```
git init
```
Now the directory is a *local* (existing on your machine rather than somewhere else) *repository* (virtual storage space).

You can check the status of the repo anytime:
```
git status
```
Check the status after each of the following subsections!

## git areas
As a useful abstraction, several areas in the git workflow can be defined: the sandbox, the staging area, the local repository and the remote repository. The sandbox is simply the files and folders of your project, untracked by default and hence the easiest to lose. Modifications to them overwrite each other until the files are made tracked with `git add`. After that the files receive the staging area label and are promised to be recorded in that state (at the time of running `git add`) when `git commit` is executed later. The local repo label is applied to files with committed changes; these are easy to trace back. Finally, commits can be pushed to a remote repository to be made accessible to other contributors or recovered in case the local storage becomes inaccessible.

Right, there's also the stash area to keep those annoying files not ready to be staged or removed.

## tracking changes
Create file `todo.txt` within the folder and write a line in it. As of yet, the file is part of the sandbox only; it is untracked and easy to mess up or lose: if you delete that first line and crash the editor, the line is gone forever. Make it tracked (known to Git):
```
git add todo.txt
```
Now you have made the file *staged*: on the next commit the file as it looks right now will become part of the local repository. Note that:
> \[[git-book](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)\] If you modify a file after you run `git add`, you have to run `git add` again to stage the latest version of the file.

To commit means to persist changes in the repository. The files in the repo can be reverted back to any committed version. You can think of this similar to the multiverse theory: with each commit, the universe of your project branches, so that if you are unhappy with a branch you are perching on, you can go back to where the branch originated and take a parallel branch. Do not ignore the commit message &mdash; these make it easier to navigate through the change history!
```
git commit -m "initial commit of todo.txt"
```
[Here](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) are some best practices for Git messages. Each commit gets a unique SHA hash which can be used to identify it. You can look up the history of commits:
```
git log --oneline
```

## fixing the screwed-up
The following describes four cases which I have encountered the most frequently. All other cases are left for you to explore on demand.

### 1. roll back recent changes
Reason: the changes made to a file since the previous commit (or clone/pull) are bad, and I just want to undo those.
```
git restore <filename>
```

### 2. go back to a particular commit
Reason: I want to see what a file looked like at a particular point in time:
```
git checkout <SHA> <filename>
```
where `<SHA>` is the hash ID of a particular commit. At the beginner level of Git proficiency this is only advised to look at the files, maybe run tests etc., eventually undoing all changes since `git checkout` and going back to the main development branch via `git checkout main`.

### 3. roll back all changes
Reason: everything since a previous commit is ugly and I do not want to see the files or commits anymore.
```
git reset <SHA> --hard
```
Make sure you **really** mean it though, as your repo will be updated to match the specified commit and all staged and unstaged changes will be lost. Also, this is only good for undoing changes that haven’t been shared with anyone else (via `git push` to be covered later).

### 4. roll back changes via a new commit
Reason: A previous commit was bad, and I want to undo those changes, but keep the bad commit in the history.

```
git revert <SHA>
```
This is kind of applying the inverse of a commit from your project history. Let the `<SHA>` of the commit you do not like be `r11111`. If you run `git revert r11111`, a new commit is made with a new `<SHA>`, let it read `r22222`. Now, if you run `git revert r22222`, the repo is back to where you started before running the first revert.

Unlike `git reset`, this command adds a new commit that restores the tree to some previous state instead of clipping the tree. This is both safer and easier to work with, especially if you previously pushed your commit and others cloned it. In general, **never use `git reset` when changes have been pushed to a public repository and other people rely on them**.

## ignoring files
Some files and folders do not need to be tracked, for instance, temporary files, binary files such as pictures, large data containers (a .csv file with stock price history), auxiliary files such as LaTeX's .aux and .fft, project-specific software settings etc. To exclude those, you can create file called `.gitignore` in your repo and fill it with relative or absolute paths to files and folders that you want to exclude from version control. Some examples:

path | purpose
--- | ---
`data/`  |  folder **data/**
`data/*` <br> `!data/description.txt` | everything in folder **data/** except file **description.txt**
`*.log` | files with extension '**.log**'

Note however that
> Git will continue to track any files that are already being tracked.

To stop tracking a file, see [this answer](https://stackoverflow.com/questions/1274057/how-to-make-git-forget-about-a-file-that-was-tracked-but-is-now-in-gitignore).

## publishing changes
If you want to share your project (or just make it accessible from everywhere), you would have to find a *remote* to store your repository. Places like [https://www.atlassian.com/](atlassian.com) and [https://github.com/](github.com) offer this possibility (but you could also set it up on an own server). Once you have an account, you can create a remote and point your local repository to it.
```
git remote add <shortname> <url>
```
where `<shortname>` is a mnemonic, most frequently set to 'origin'. Clearly, the `<url>` must exist. Alternatively, you can create an empty remote on Github first, then _clone_ it to the local machine:
```
git clone <url>
```
More on remotes, including the very important and quite annoying authentication process [here](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories).

Having committed stuff, it is time to *push* it to the remote repo thus making the changes public. Anyone with access to the remote repo will be able to integrate the changes into their own working copy.
```
git push
```

## resources
*   [difference between `checkout`, `reset` and `revert`](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting);
*   [lots of useful path examples for .gitignore](https://www.atlassian.com/git/tutorials/saving-changes/gitignore);
*   [lots of useful templates of `.gitignore` files](https://github.com/github/gitignore).


## exercises
1.  Install Git;
2.  Create an account on Github (or use an existing if you want);
3.  Set up a local repository in your project folder;
4.  Within it, create the following two folders and two files:

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
