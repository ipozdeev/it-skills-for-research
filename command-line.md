# command line

Also known as shell, terminal or prompt, the command line can be used for efficient file manipulation (bulk rename files), task management (run a web scraper every evening), operating software without user interface (anaconda), running a Linux server and making do without a mouse in general. Pretty much everything you do on you computer has or can have a command line analogue.


## installation
The command line is pre-installed, of course, and can be called up on Windows via `Start` -> `cmd` or executing `cmd` from `Win+R`. 

For Sublime, install package 'Terminus' to be able to open a terminal panel in the editor. Conveniently, the terminal will automatically navigate to the current project working directory.


## commands
A command such as `echo` or `pdflatex` can be run in the shell as long as the shell knows where to find the executable file of the same name. How can it know? It searches the following places in the stated order:

1. the list of internal (embedded in the shell) commands;
2. executables in the current directory;
3. executables in the **PATH** environment variable.

With that in mind, `echo` can be run because it is an internal command; `pdflatex` can because `pdflatex.exe` has been put into one of the directories from the **PATH** variable.

Commands tend to have arguments: for instance,
```bash
pdflatex presentation.tex
```
would compile and create a .pdf from file `presentation.tex`, the latter being the argument to the command.


## scripts
Commands can be packaged in scripts (batch on Windows, bash on Linux) which are executable files themselves. Everything you can execute in the shell you can execute using a written script. A simplest example would be a text file called 'todo-creator.bat' with the following line of code:
```bash
echo "" > todo.txt
```
When executed:
```bash
todo-creator
```
this batch script will create file `todo.txt` in the current directory (and write some stuff in it too).


## automating tasks
Scripts can be executed automatically at a specified time. All you need is a working script, correct path references and a task in the task scheduler of choice (Task Scheduler on Windows, crontab on Linux/Mac). As an example, web scraping can be automated to run 
