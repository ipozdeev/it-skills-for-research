# collaboration tools

- [collaboration tools](#collaboration-tools)
  - [participating in project](#participating-in-project)
  - [distributed workflow](#distributed-workflow)
  - [pull requests](#pull-requests)
  - [exercises](#exercises)

International collaborations account for almost one-quarter of all publications. They arise from people meeting each other at conferences, after guest seminars, through mutual friends, and clearly require some tools to be productive. In what follows, we will discuss how git fosters collaboration.

## participating in project

With git, it is possible for many developers to work on the same file simultaneously and seamlessly, without asking each other to 'please close that Excel'. Having set up a remote repository and made it public, others can start to participate in the project by cloning the repo:

```bash
git clone https://github.com/ipozdeev/digital-tools-for-finance.git
```

This will download all tracked content of the repo to the target machine.

## distributed workflow

Let there be two users: [Alice and Bob](https://en.wikipedia.org/wiki/Alice_and_Bob#History). If both introduce changes to the repo and try to push them to the remote, the first one to do so &ndash; let it be Alice &ndash; will not face any problems, but the other &ndash; Bob &ndash; will have to merge the pushed changes with their working copy first. To do so, Bob must first run `git fetch` followed by `git merge`, and finally `git push` again. The former brings Bob's local copy of the repo up-to-date with the remote **without modifying his files**; the latter does attempt to modify.

> [Why it might be a bad idea to use `git pull` instead](https://longair.net/blog/2009/04/16/git-fetch-and-merge/)

If Alice's changes are not in conflict with Bob's, e.g. because Alice changed file `alice.txt` and Bob changed `bob.bib`, the merge would run smoothly. Otherwise, e.g. if both of them worked on the same file, conflicts arise which need to be solved by Bob by either discarding Alice's changes, or his, or carefully weaving the changes into the fabric of the file. Software like VS Code and PyCharm offer fantastic user interface for doing so.

## pull requests

A handy way to notify team members that something has been pushed are **pull requests**. Once a feature is ready, the author files a pull request via their github or bitbucket account. This is akin to sending a message asking to 'please pull and take a look'.

So, what's wrong with just sending a message? As discussed on \[[atlassian](https://www.atlassian.com/git/tutorials/making-a-pull-request)\]:
> \[...\] the pull request is more than just a notification &ndash; it’s a dedicated forum for discussing the proposed feature. If there are any problems with the changes, teammates can post feedback in the pull request and even tweak the feature by pushing follow-up commits. All of this activity is tracked directly inside of the pull request.

Imagine that Alice is working on a branch of her joint project with Bob and Chuck. By committing her changes, pushing them to the remote and filing a pull request, she encourages the other two to take a look and discuss what can be improved here before merging the branch into the main history.

This might be of little extra value when working in a team of 2, but quickly becomes useful as the number of participants is growing.

## exercises

1. Re-do the toy example of a two-person workflow from `src/git/git-workflow.txt` (extending it to three or more people if you want).
