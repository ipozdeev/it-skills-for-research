# collaboration tools

- [collaboration tools](#collaboration-tools)
  - [git](#git)
    - [participating in project](#participating-in-project)
    - [distributed workflow](#distributed-workflow)
    - [branching](#branching)
    - [pull requests](#pull-requests)
  - [slack](#slack)
    - [searchable conversations](#searchable-conversations)
    - [slack apps](#slack-apps)
  - [whiteboards](#whiteboards)
  - [exercises](#exercises)

International collaborations account for almost one-quarter of all publications. They arise from people meeting each other at conferences, after guest seminars, through mutual friends, and clearly require some tools to be fruitful. In what follows, we will discuss how to collaborate using Git acquainted with before ever so slightly enhanced in functionality with software called Slack.

## git

### participating in project

With git, it is possible for many developers to work on the same file simultaneously and seamlessly, without asking each other to 'please close that Excel'. Having set up a remote repository and made it public, others can start to participate in the project by cloning the repo:

```bash
git clone https://github.com/ipozdeev/digital-tools-for-finance.git
```

This will download all tracked content of the repo to the target machine.

### distributed workflow

Let there be two users: [Alice and Bob](https://en.wikipedia.org/wiki/Alice_and_Bob#History). If both introduce changes to the repo and try to push them to the remote, the first one to do so &ndash; let it be Alice &ndash; will not face any problems, but the other &ndash; Bob &ndash; will have to merge the pushed changes with their working copy first. In other words, Bob must first run `git fetch` followed by `git merge`, and finally `git push` again. The former brings Bob's local copy of the repo up-to-date with the remote **without modifying his files**; the latter does attempt to modify.

> [Why it might be a bad idea to use `git pull` instead](https://longair.net/blog/2009/04/16/git-fetch-and-merge/)

If Alice's changes are not in conflict with Bob's, e.g. because Alice changed file `alice.txt` and Bob changed `bob.bib`, the merge would run smoothly. Otherwise, e.g. if both of them worked on the same file, conflicts arise which need to be solved by Bob by either discarding Alice's changes, or his, or carefully weaving the changes into the fabric of the file. Software like Atom and PyCharm offer fantastic user interface for doing so.

### branching

Sometimes, it might be useful to create a line of development separate from what is happening to the repository. For instance, your paper finally looks OK in terms of tables, figures and text, but the appearance needs polishing. In order to keep the appearance-related changes far from your econometrics code, you could create a **branch**, work on it, and then, when all seems safe enough, integrate the changes back. As the \[[atlassian](https://www.atlassian.com/git/tutorials/using-branches)\] puts it:
> You can think of [a new branch] as a way to request a brand new working directory, staging area, and project history. New commits are recorded in the history for the current branch, which results in a fork in the history of the project.

By default, you are on a branch too! The main branch, assigned by default to any new repository, is called `master`. You can create a new branch by issuing command `git branch <branch-name>`. This does not automatically switch to the newly created branch! To do the switch, use `git checkout <branch-name>`.

Now, you can work on files, add and commit and push the changes to the new branch as usual. Then, when you are happy with the development, you can merge the branch back into the `master` by checking it out first and then running `git merge`:

```bash
git checkout master
git merge <branch-name>
```

### pull requests

A handy way to notify team members that something has been pushed are **pull requests**. Once a feature is ready, the author files a pull request via their github or bitbucket etc. account. This is akin to sending a message asking to 'please pull and take a look'.

So, what's wrong with just sending a message? As discussed on \[[atlassian](https://www.atlassian.com/git/tutorials/making-a-pull-request)\]:
> \[...\] the pull request is more than just a notification &ndash; it’s a dedicated forum for discussing the proposed feature. If there are any problems with the changes, teammates can post feedback in the pull request and even tweak the feature by pushing follow-up commits. All of this activity is tracked directly inside of the pull request.

Imagine that Alice is working on a branch of her joint project with Bob and Chuck. By committing her changes, pushing them to the remote and filing a pull request, she encourages the other two to take a look and discuss what can be improved here before merging the branch into the main history.

This might be of little extra value when working in a team of 2, but quickly becomes useful as the number of participants is growing.

## slack

Slack is a software not dissimilar to WhatsApp, which organizes collaboration through chat windows called channels. It is a well-contrived, extensible, all-in-one-place alternative to _internal_ emails, text messages and other types of communication. You can use Slack as a web, desktop or mobile app. So, let us try to run it however you prefer; you will be sent an invite to workspace `digital-tools-for-finance` during the lecture.

### searchable conversations

Slack allows to search in the conversation history. [Modifiers](https://slack.com/intl/en-ch/help/articles/202528808-Search-in-Slack#h_5ece87ed-b336-4ae0-86dd-54221c2d2c03) such as `before:4/12/2019` come in super handy!

### slack apps

To add a specific feature to Slack, e.g. functionality to create polls or your Outlook calendar, you should add what is called [an app](https://slack.com/intl/en-ch/resources/slack-101/what-is-an-app). For now, let us install something to help us integrate a github account, make Zoom calls and create polls, of course.

## whiteboards

Writing things down is an essential component of any research project: from planning to maintaining a research log. Apps like [miro](https://miro.com/) and [Stormboard](https://stormboard.com/) are digital whiteboards with a number of important features: unlimited space, ability to invite other people to work simultaneously, integration with other apps like the ones for project management or presentations.

The whiteboards can be used for literally anything: task planning, brain-storming sessions, logging intermediary research results, etc.

## exercises

1. Re-do the toy example of a two-person workflow (possibly extending it to three or more people);
1. Create a slack group and invite your collaborators;
1. Install an app to create polls and the Zoom app;
1. Create an invitation to join a Zoom meeting;
1. Go to [miro.com](https://miro.com/) and log in or sign up;
1. Create a new whiteboard;
1. Invite another person to collaborate (miro can access slack).
