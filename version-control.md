# version control

- [version control](#version-control)
  - [basics](#basics)
  - [installation](#installation)
  - [starting to version control](#starting-to-version-control)
  - [git areas](#git-areas)
  - [tracking changes](#tracking-changes)
  - [branching](#branching)
  - [fixing the screwed-up](#fixing-the-screwed-up)
    - [1. roll back recent changes](#1-roll-back-recent-changes)
    - [2. go back to a particular point in history](#2-go-back-to-a-particular-point-in-history)
    - [3. roll back all changes](#3-roll-back-all-changes)
    - [4. roll back changes via a new commit](#4-roll-back-changes-via-a-new-commit)
  - [ignoring files](#ignoring-files)
  - [publishing changes](#publishing-changes)
  - [tags](#tags)
  - [resources](#resources)
  - [exercises](#exercises)

## basics

A version control system is a software that keeps track of the files you are working on, recording introduced modifications and allowing to recall and undo them &ndash; not unlike the backup feature of an operating system or checkpoints in a computer game. It also facilitates concurrent editing and allows groups of people to efficiently work on the same set of files without running into conflicts. Version control is great for all things text: first and foremost code (where it is becoming a must), but also dissertations, memos and reports.

There are several version control systems around such as Git and Subversion; we will be using Git here. As stated on the [webpage](https://git-scm.com/):
> Git is a free and open source distributed version control system...

Here, *free* means you do not have to pay for it; *open source* &ndash; that the code behind it is not proprietary (you can download, customize and amend it); *distributed* &ndash; [this](https://www.atlassian.com/blog/software-teams/version-control-centralized-dvcs).

The following is based on \[[atlassian](https://www.atlassian.com/git/tutorials)\] and \[[git-book](https://git-scm.com/book/en/v2)\].

## installation

Follow the instructions on the webpage to install Git. Now, to operate Git you can:

- enter commands in the command line;
- rely on your favorite text editor's built-in Git integration;
- use a specialized third software such as Sublime Merge.
Choose whatever you like! In this tutorial, we will stick to the first option. Obviously, the same commands we will be executing power the Git features of your favorite text editor or third software.

> \[[git-book](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)\] The first thing you should do when you install Git is to set your user name and email address.

## starting to version control

You can put a directory under version control &mdash; and the project directory is an obvious choice! Go to the directory associated with the project you would like to start tracking and execute

```bash
git init
```

Now the directory is a *local* (existing on your machine rather than somewhere else) *repository* (virtual storage space).

You can check the status of the repo anytime:

```bash
git status
```

Check the status after each of the following subsections!

## git areas

As a useful abstraction, several areas in the git workflow can be defined: the sandbox, the staging area, the local repository and the remote repository. The sandbox is simply the files and folders of your project, untracked by default and hence the easiest to lose. Modifications to them overwrite each other until the files are made tracked with `git add`. After that the files receive the staging area label and are promised to be recorded in that state (at the time of running `git add`) when `git commit` is executed later. The local repo label is applied to files with committed changes; these are easy to trace back. Finally, commits can be pushed to a remote repository to be made accessible to other contributors or recovered in case the local storage becomes inaccessible.

Right, there's also the stash area to keep those annoying files not ready to be staged or removed.

## tracking changes

Create file `todo.txt` within the folder and write a line in it. As of yet, the file is part of the sandbox only; it is untracked and easy to mess up or lose: if you delete that first line and crash the editor, the line is gone forever. Make it tracked (known to Git):

```bash
git add todo.txt
```

Now you have made the file *staged*: on the next commit the file as it looks right now will become part of the local repository. Note that:
> \[[git-book](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)\] If you modify a file after you run `git add`, you have to run `git add` again to stage the latest version of the file.

To commit means to persist changes in the repository. The files in the repo can be reverted back to any committed version. Do not ignore the commit message &mdash; these make it easier to navigate through the change history!

```bash
git commit -m "initial commit of todo.txt"
```

[Here](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) are some best practices for Git messages. Each commit gets a unique SHA hash which can be used to identify it. You can look up the history of commits:

```bash
git log --oneline
```

## branching

Sometimes, it might be useful to create a line of development separate from what is happening in the repository. For instance, your paper finally looks OK in terms of tables, figures and text, but the appearance needs polishing. In order to keep the appearance-related changes far from your econometrics code, you could create a **branch**, work on it, and then, when all seems safe enough, integrate the changes back. As the \[[atlassian](https://www.atlassian.com/git/tutorials/using-branches)\] puts it:
> You can think of [a new branch] as a way to request a brand new working directory, staging area, and project history. New commits are recorded in the history for the current branch, which results in a fork in the history of the project.

By default, you are on a branch too! The main branch, assigned by default to any new repository, is called `master`. You can create a new branch by issuing command `git branch <branch-name>`. This does not automatically switch to the newly created branch! To do the switch, use `git checkout <branch-name>`. Thanks to its clever innards, branching in git is for free in terms of hard drive spacetime!

Now, you can work on files, add and commit and push the changes to the new branch as usual. Then, when you are happy with the development, you would need to make your changes visible on the master branch. For this you have two options. You can either merge the branch back into the `master` by checking out `master` first and then running `git merge`:

```bash
git checkout master
git merge <branch-name>
```

Alternatively, you can rebase the master branch onto the current one:

```bash
git rebase master
```

The main difference between `merge` and `rebase` is that the former keeps the merged branch away from the rest, whereas the latter makes it part of the something else; the details are important and interesting and discussed [here](https://www.atlassian.com/git/tutorials/merging-vs-rebasing).


## fixing the screwed-up

The following describes four cases which I have encountered the most frequently. All other cases are left for you to explore on demand.

### 1. roll back recent changes

Reason: the changes made to a file since the previous commit (or clone/pull) are bad, and I just want to undo those.

```bash
git restore <filename>
```

### 2. go back to a particular point in history

Reason 1: I want to take a look at/restore *one file* to a particular state:

```bash
git checkout SHA <filename>
```

where `SHA` is the hash ID of a particular commit, and `<filename>` if the name of the file. 

Reason 2: I want to take a look at/restore the whole repo to a particular state:

```bash
git checkout SHA
```

This would put ypur repo in the 'detached HEAD state', meaning that all changes/commits done from here are 'orphaned' and to be deleted by the git garbage collector. If you need to persist them, create and checkout a branch, work on it and then merge as discussed above.

### 3. roll back all changes

Reason: everything since a previous commit is ugly and I do not want to see the files or commits anymore.

```bash
git reset SHA --hard
```

Make sure you **really** mean it though, as your repo will be updated to match the specified commit and all staged and unstaged changes will be lost. Also, this is only good for undoing changes that haven’t been shared with anyone else (via `git push` to be covered later).

### 4. roll back changes via a new commit

Reason: A previous commit was bad, and I want to undo those changes, but keep the bad commit in the history.

```bash
git revert SHA
```

This is kind of applying the inverse of a commit from your project history. Let the `SHA` of the commit you do not like be `r11111`. If you run `git revert r11111`, a new commit is made with a new `SHA`, let it read `r22222`. Now, if you run `git revert r22222`, the repo is back to where you started before running the first revert.

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

Empty folders are not added to the repo! A simple workaround is to add an empty file, usually called `.gitkeep`, to the folder you want to push.


## publishing changes

If you want to share your project (or just make it accessible from everywhere), you would have to find a *remote* to store your repository. Places like [https://www.atlassian.com/](atlassian.com) and [https://github.com/](github.com) offer this possibility (but you could also set it up on an own server). Once you have an account, you can create a remote and point your local repository to it.

```bash
git remote add <shortname> <url>
```

where `<shortname>` is a mnemonic, most frequently set to 'origin'. Clearly, the `<url>` must exist. Alternatively, you can create an empty remote on Github first, then *clone* it to the local machine:

```bash
git clone <url>
```

More on remotes, including the very important and quite annoying authentication process [here](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories).

Having committed stuff, it is time to *push* it to the remote repo thus making the changes public. Anyone with access to the remote repo will be able to integrate the changes into their own working copy.

```bash
git push
```

## tags

A tag is a label placed on a particular commit that makes it more recognizable. A common use case for tags is versioning your code: "v1.0", "v1.1" etc. To place a tag, use (`-lw` for lightweight)

```bash
git tag <TAG NAME>-lw
```

You can use tags just like commit SHA to checkout stuff, but note that tags must be pushed explicitly:

```bash
git push origin <TAG NAME>
```

## resources

- [git internals](https://www.youtube.com/watch?v=P6jD966jzlk) for those who want to understand how git works;
- [undoing things in git](https://www.atlassian.com/git/tutorials/undoing-changes)
- [difference between `checkout`, `reset` and `revert`](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting);
- [lots of useful path examples for .gitignore](https://www.atlassian.com/git/tutorials/saving-changes/gitignore);
- [lots of useful templates of `.gitignore` files](https://github.com/github/gitignore).

## exercises

1. Install Git;
1. Create an account on Github (or use an existing if you want);
1. Set up a local repository in your project folder;
2. Create folder `homework/week3`;
3. Within it, create the following two folders and two files:

```bash
data/
text/
notes.txt
functions.py
```

and exclude folder `data/` from being tracked;

1. Add and commit everything;
1. Add line reading 'THIS IS FINE' to `notes.txt`, commit the new version with message 'a fine change';
1. Change that line to 'THIS IS GOOD', commit the new version with message 'a good change' *overwriting the previous commit* as if it never happened (make sure `git log` does not show 'a fine change');
1. Change that line to 'THIS IS BAD', save the file and close the editor to make it impossible to use `Ctrl+Z`;
1. Try to restore `notes.txt` to the state where it reads 'THIS IS GOOD';
1. Change that line to 'THIS IS THE BEST' and delete file `functions.py`, commit your changes giving your commit a name such as 'first-working';
1. Undo the previous commit using `git revert`, makes sure `functions.py` does exist and the line reads 'THIS IS GOOD';
1. Create a remote repo on Github/Bitbucket and link your local repo to it;
1. Push all the commits to the remote;
1. Try to revert `notes.txt` to the state where it reads 'THIS IS FINE' keeping all the other changes in place;
1. Commit everything pending and push to the remote;
1. Commit and push the previous homework.
