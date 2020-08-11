<!-- TOC -->

-   [git](#git)
    -   [participating](#participating)
    -   [distributed workflow](#distributed-workflow)
    -   [pull requests](#pull-requests)
-   [slack](#slack)
    -   [polls](#polls)
    -   [zoom](#zoom)

<!-- /TOC -->

# collaboration-tools
International collaborations account for almost one-quarter of all publications. They arise from people meeting each other at conferences, after guest seminars, through mutual friends, and clearly require some tools to be fruitful. In what follows, we will discuss how to collaborate using Git acquainted with before ever so slightly enhanced in functionality with software called Slack.

## git
### participating in project
With git, it is possible for many developers to work on the same file simultaneously and seamlessly, without asking each other to 'please close that Excel'. Having set up a remote repository and made it public, others can start to participate in the project by cloning the repo:
```
git clone ipozdeev/digital-tools-for-finance
```
This will download all tracked content of the repo to the cloner's machine.

### distributed workflow
Let there be two users: [Alice and Bob](https://en.wikipedia.org/wiki/Alice_and_Bob#History). If both introduce changes to the repo and try to push them to the remote, the first one to do so &ndash; let it be Alice &ndash; will not face any problems, but the other &ndash; Bob &ndash; will have to merge the pushed changes with their working copy first. In other words, Bob must first run `git fetch` followed by `git merge`, and finally `git push` again. The former brings Bob's local copy of the repo up-to-date with the remote **without modifying his files**; the latter does attempt to modify.

> [Why it might be a bad idea to use `git pull` instead](https://longair.net/blog/2009/04/16/git-fetch-and-merge/)

If Alice's changes are not in conflict with Bob's, e.g. because Alice changed file `alice.txt` and Bob changed `bob.bib`, the merge would run smoothly. Otherwise, e.g. if both of them worked on the same file, conflicts arise which need to be solved by Bob by either discarding Alice's changes, or his, or carefully weaving the changes into the fabric of the file. Software like Atom and PyCharm offer fantastic user interface for doing so.

### pull requests
A handy way to notify team members that something has been pushed are **pull requests**. Once a feature is ready, the author files a pull request via their github or bitbucket etc. account. This is akin to sending a message asking to 'please pull and take a look'.

So, what's wrong with the message? As discussed on [bitbucket](https://www.atlassian.com/git/tutorials/making-a-pull-request):
> \[...\] the pull request is more than just a notification &ndash; it’s a dedicated forum for discussing the proposed feature. If there are any problems with the changes, teammates can post feedback in the pull request and even tweak the feature by pushing follow-up commits. All of this activity is tracked directly inside of the pull request.

Imagine that Alice is working on Figure 1 of her joint project with Bob and Chuck. By committing her changes, pushing them to the remote and filing a pull request, she encourages the other two to take a look and discuss what can be improved here.

This might be of little extra value when working in a team of 2, but quickly becomes useful as the number of participants is growing.

## slack
Slack is software not dissimilar to WhatsApp which organizes collaboration through chat windows called channels. You can use it in your web browser or as a desktop app. If you have not yet done so, please download Slack from [here](https://slack.com/). You will be sent an invite during the lecture.

### slack apps
To add a specific feature to Slack, e.g. functionality to create polls or your Outlook calendar, you should add what is called [an app](https://slack.com/intl/en-ch/resources/slack-101/what-is-an-app). For now, let us install something to help us integrate the Github account, make Zoom calls and create polls, of course.
