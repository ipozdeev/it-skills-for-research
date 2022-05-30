# command line

- [command line](#command-line)
  - [installation](#installation)
  - [commands](#commands)
  - [scripts](#scripts)
  - [automating tasks](#automating-tasks)
  - [resources](#resources)
  - [exercises](#exercises)

Also known as shell, terminal or prompt, the command line can be used for efficient file manipulation (bulk rename files), task management (run a web scraper every evening), operating software without user interface (git, conda), running scripts on a Linux server (e.g. on ETH's [Euler](https://scicomp.ethz.ch/wiki/Scientific_computing_services)) and making do without a mouse in general. Pretty much everything you do on your computer has or can have a command line analogue.

Several cases for using the command line can be found [here](https://www.nature.com/articles/d41586-021-00263-0), although you can perform the same tasks with your favorite programming language.

## installation

There are different shells around, across operating systems and within one, such as **bash** and **zsh** on Linux or **cmd** and **PowerShell** on Windows, but they do not differ critically. Some shell always comes pre-installed.

Advanced text editors offer a possibility to open a terminal at the root of the workspace (installation of a dedicated extension may be necessary).

## commands

A command such as `echo` or `pdflatex` can be run in a shell as long as the shell knows where to find the executable file of the same name. How can it know? It searches the following places in the stated order:

1. the list of internal (embedded in the shell) commands;
2. executables in the current directory;
3. executables in **PATH**.

With that in mind, `echo` can be run because it is an internal command; `pdflatex` can because `pdflatex.exe` has been put into one of the directories from the **PATH** variable.

Commands tend to have *parameters*: for instance,

```bash
pdflatex presentation.tex
```

would compile and create a .pdf from file `presentation.tex`, the latter being the parameter to the command.

Commands can also have options, indicated with a double dash: for instance,

```bash
pdflatex presentation.tex --output-directory=DIR
```

would use existing `DIR` as the destination for generated files, instead of the current working directory. An option parameter (such as `DIR`) can be separated from the option name (such as `output-directory`) by a space ' ', equality sign '=' or colon ':'.

## scripts

Shell commands can be packaged as scripts to be run "in bulk". Scripts are  shell-specific, although for the most basic purposes the differences are minor. Scripts intended for Linux `bash` tend to have extension ".sh", Windows `cmd` scripts &ndash; ".bat", Windows PowerShell &ndash; ".ps1" and so on. A simplest example of a bash script would be a text file called 'todo-creator.sh' with the following line of code:

```bash
echo "" > todo.txt
```

When executed:

```bash
./todo-creator
```

this script creates file `todo.txt` in the current directory (and write some stuff in it too). Note that executing bash scripts may require [changing the permissions](https://www.redhat.com/sysadmin/introduction-chmod).

It is possible (and quite handy) to write scripts that accept parameters and options, just like a command would.

## automating tasks

Scripts can be executed automatically at a specified time. All you need is a working script (with correct permissions as note above), correct path references and a task in the task scheduler of choice (**Task Scheduler** on Windows, **crontab** on Linux/Mac). As an example, web scraping or mail feed can be automated.

On Linux, `crontab` is used to manage tasks.

## resources

- [command line tutorial](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Understanding_client-side_tools/Command_line) from mozilla;
- [bash scripting tutorial](https://linuxconfig.org/bash-scripting-tutorial-for-beginners);
- [crontab reference](https://www.tutorialspoint.com/unix_commands/crontab.htm).

## exercises

Using the shell of your choice:

- write a bash script (one you could execute on a Linux server) called "runner.sh" which prints the message provided by the user as a parameter to the script; for instance,

  ```bash
  ./runner.sh 'hello'
  ```

  is supposed to display "hello";  
- write a text document describing the steps necessary for a user without superuser privileges to create a cron job on a Linux server that runs every second day at 17:00 executing script "runner.sh 'hello'";
- place both files above in folder "homework/week1" (you will commit and push them once we've covered version control).
