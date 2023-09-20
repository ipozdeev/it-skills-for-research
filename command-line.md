# command line

- [command line](#command-line)
  - [installation](#installation)
  - [prompt](#prompt)
  - [commands](#commands)
  - [paths](#paths)
  - [superuser privileges](#superuser-privileges)
  - [tricks](#tricks)
  - [scripts](#scripts)
  - [automating tasks](#automating-tasks)
  - [resources](#resources)
  - [exercises](#exercises)

The command line is an interface of a computer, a way it can interact with the user (another way being the graphical interface of clicky icons and floating windows). It is a powerful tool that can be used for _efficient_ file manipulation (e.g. bulk renaming), task management (running a web scraper every evening), operating software without other interfaces (git, conda or virtual machines on a high performance computing cluster such as ETH's [Euler](https://scicomp.ethz.ch/wiki/Scientific_computing_services)) and making do without a mouse in general. Pretty much everything you do on your computer has or can have a command line analogue.

Several cases for using the command line can be found [here](https://www.nature.com/articles/d41586-021-00263-0) (although you can perform the same tasks with your favorite programming language).

A program allowing you to use the command line is called a **shell**. Oftentimes, 'command line', 'shell', 'terminal' and 'console' are used interchangeably.

## installation

There are different shells around, both across operating systems and within one, such as **bash** and **zsh** on Linux or **cmd** and **PowerShell** on Windows, but they do not differ critically. Some shell always comes pre-installed.

In what follows, we will be using the shell called **bash**, which is the default option in Linux. So, if you are on Linux, just spawn a terminal; if on Mac, change the default Terminal shell to **bash**; if on Windows, install `wsl` to get access to a whole actual Linux instance operated via **bash**.

Advanced text editors offer a possibility to open an integrated terminal (installation of a dedicated extension may be necessary).

## prompt

To the left of where you are supposed to type commands is the _prompt_ which can look like this:
```bash
user@host:~$
```

By default, the prompt is supposed to give you some information about who  you are (user) and what is at your command (host), as well as about the path to your current directory (`~`); it can be customized to display other stuff.

## commands

A command such as `pwd` or `pdflatex` can be run in a shell as long as the shell knows where to find the executable file of the same name. How can it know? It searches the following places in the stated order:

1. the list of internal (embedded in the shell) commands;
2. executables specified in the environment variable called `$PATH`.

With that in mind, `pwd` can be run because it is an internal command; `pdflatex` can because `pdflatex.exe` has been put into one of the directories from the `$PATH` variable.

Environment variables will be covered in more detail later; for now, it suffices to know that `$PATH` is a long string referencing all the places where to look for executables:
```bash
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:
```

Commands tend to have *arguments*: for instance,

```bash
pdflatex presentation.tex
```

would compile and create a .pdf from file `presentation.tex`, the latter being the argument to the command.

Commands can also have options, or _flags_, indicated with a single or double dash: for instance, 
```bash
shutdown
``` 
would shut the computer down, but
```bash
shutdown -r
```
would restart it instead. To make things even more complicated, options can have arguments themselves! For instance,

```bash
pdflatex presentation.tex -output-directory=DIR
```

tells `pdflatex` to use an existing directory `DIR` as the destination for generated files, instead of the current working directory. An option argument (here, `DIR`) can be separated from the option name (here, `output-directory`) by a space ' ', equality sign '=' or colon ':'.

> [What's the difference between one dash and two dashes?](https://superuser.com/q/372203/1731633)

One super popular flag is `--help`: running a command with it would give you, well, some help on the command.

## paths

A path is the address of a file or folder, such as `/home/alan.smithee/projects/project_1/README.md` or `C:\Users\Alan.Smithee\Downloads`. There are absolute and relative paths: the former give the 'full' address, start at the root of the file system (`/` on Linux) and uniquely identify an object, while the latter give the address relative to the current directory. 

In standard file systems, a shell is always spawned with some path set as the current directory.

You can always check your whereabouts with `pwd`, and change them with `cd`. If your programs cannot find a file, it is often the case that the path to the file is misspecified. The above symbol `~` ('tilde') is the shortcut for the 'home' directory (`/home/<user.name>` by default).

## superuser privileges
Running some commands (`apt install`, for one) requires the user to prove that they have administrator, or superuser, privileges: this is achieved in **bash** by prepending the command with `sudo `, e.g. `sudo apt install`, and prompts you to type in your password.

## tricks

- copying (pasting) with `Ctrl+C` (`Ctrl+V`) does not work &ndash; use `Ctrl+Shift+C(V)` instead;
- hitting `Up` and `Down` arrows lets you scroll through the command history;
- command `history` lists the most recent commands;
- hitting `Tab` gives you autocomplete;
- `Ctrl+R` lets you search for keywords in the typed commands;
- `Ctrl+L` clears the console;
- `Ctrl+C` does its best to kill whatever is currently being executed.

## scripts

Shell commands can be packaged as scripts to be run in bulk. Scripts are  shell-specific, although for the most basic purposes the differences are minor. Scripts intended for `bash` on Linux tend to have extension '.sh', Windows `cmd` scripts &ndash; '.bat', Windows PowerShell &ndash; '.ps1' and so on. A simplest example of a bash script would be a text file called 'todo-creator.sh' with the following line of code:

```bash
echo "" > todo.txt
```

When executed:

```bash
./todo-creator
```

this script creates file `todo.txt` in the current directory (and write some stuff in it too). Note that executing bash scripts may require [changing permissions](https://www.redhat.com/sysadmin/introduction-chmod).

It is possible (and quite handy) to write scripts that accept arguments and options, just like a command would.

## automating tasks

Scripts can be executed automatically at a specified time. All you need is a working script (with correct permissions as note above), correct path references and a task in the task scheduler of choice (**Task Scheduler** on Windows, `crontab` on Linux/Mac). As an example, web scraping or mail feed can be automated.

## resources

- [an online terminal to learn the basics](https://cocalc.com/);
- [command line tutorial](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Understanding_client-side_tools/Command_line) from mozilla;
- [command line course](https://zi-training.zi.uzh.ch/en/page/operating-systems-programming/science-it-linux-command-line) from uzh;
- [command line challenge](https://cmdchallenge.com);
- [bash scripting tutorial](https://linuxconfig.org/bash-scripting-tutorial-for-beginners);
- [crontab reference](https://www.tutorialspoint.com/unix_commands/crontab.htm);
- [future of the command line](https://github.com/readme/featured/future-of-the-command-line) from github.

## exercises

- ask ChatGPT to give you the most commonly used shorthand symbols for directory navigation in **bash**, such as `..`;
- ask ChatGPT to give you five most commonly used **bash** operators;
- ask ChatGPT to list 12 most used **bash** commands with a brief description of each.
