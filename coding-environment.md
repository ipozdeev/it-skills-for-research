# coding environment

- [coding environment](#coding-environment)
  - [local environment](#local-environment)
  - [virtual environment](#virtual-environment)
  - [docker](#docker)
    - [installation](#installation)
    - [image](#image)
    - [container](#container)
    - [build your own image](#build-your-own-image)
    - [file transfer](#file-transfer)
    - [useful tricks](#useful-tricks)
  - [resources](#resources)

For every project, there exists a set of necessary and sufficient *dependencies*: hardware (such as a GPU with CUDA support), software (Python v3.9.0 with package 'scipy' v1.8.0), data (a feather file containing stock prices), scripts (setting environment variables) and so on. This set is called the project environment, and the subset thereof that only involves the software &ndash; the coding environment. The possibility to export and share the environment is crucial for developers and should become such for researchers, as reproducibility and knowledge transfer hinges on it to a big extent.

Let's take this course as an example. To achieve ones of its goals &mdash; getting the hang of LaTeX &mdash; the audience would need a laptop and certain software installed on it. How can these software requirements be communicated?

## local environment

The easiest (for the author of the content) way would be to simply lay out all the things to be installed in a list like this:

- Ubuntu Linux v20.04 with `wget`;
- Python v.3.9 with `pandas v1.4`, `scipy v1.8`;
- R v4.0 with `shiny v1.7`;
- Julia v1.7
- gretl v2022a
- TeX Live 2022
- PostgreSQL v14.2

ans so on. The audience would then install everything from the list on the local machine, creating a local environment.

> Q: What are the disadvantages of this approach?

## virtual environment

For dealing with Python and R only, there exists a better alternative called virtual (coding) environment.

A virtual environment is an isolated configuration of interpreters that can be used instead of the system-wide ones. You can think of it as a fully autonomous installation of Python and R that can be used to run scripts. Multiple such installations can be created, each tailored to a specific project. A program that does this job is called an environment (or package) manager. Python-specific are [venv](https://docs.python.org/3/library/venv.html), itself a package, and [poetry](https://python-poetry.org/docs/managing-environments/); R-specific is [packrat](https://rstudio.github.io/packrat/); [conda](https://docs.conda.io/en/latest/) can handle both. In any case, the idea is the same: somewhere on the local machine a directory is created that contains the interpreter and packages; this directory is isolated in the sense that changing or deleting it has no effect on other interpreters present; packages needed for the code to run smoothly are installed in it; the system is told to only use the interpreter from this folder for running the project scripts.

Follow the [conda tutorial](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) to learn how to manage environments with conda.

## docker

Some projects require more than Python or R: there might be a dependency on TeX Live or PostgreSQL or gretl or even a whole operating system such as Ubuntu. These are impossible to install with `conda` or `packrat`, and a different solution is needed.

[Docker](https://docs.docker.com/) provides one such solution by packaging software into 'containers' which can be used as isolated environments ('container' is a telling term in this respect: everything needed is packaged, sealed and ready for dispatch).

One important thing to understand from the very start is that containers are really, *really* isolated, which necessitates extra steps for ordinary tasks. To name a few examples, file transfer would happen via either copy commands from an extra terminal or mounts, and mapping of ports would be needed to serve an app such as jupyter notebook from a container.

### installation

Here, we will be using the command line interface (CLI) for docker, but there are also desktop apps available for Windows and Mac which you are free to opt for.

Follow the official manual to install docker.

An extra (optional) step for Linux users to take is to give your user root privileges for the sake of running docker commands without `sudo` and having an easier time transferring files from containers. The step is described [here](https://docs.docker.com/engine/install/linux-postinstall/).

### image

In order to create a docker container that can do something useful, an 'image' is needed. Images can be thought of as configuration blueprints: you design one according to your environment requirements, then use it to `run` a container. Many pre-configured images are available on [Docker Hub](https://hub.docker.com/), with a vast range of needs covered. Having found a correct image, you can `pull` it (download the blueprint to your machine):

```bash
docker pull julia
```

To list all images you've pulled, use

```bash
docker images
```

### container

An image can be used to run a container:

```bash
docker run -it julia julia
```

where `docker run` tells the shell to run a container, tag `-it` imposes interactive mode (rather than letting the container run in the background), the first `julia` references the image from which the container is run, and `julia` at the very end states the command to evaluate from the container &mdash; call the julia shell in our example.

> Try running `bash` instead of `julia` from the julia docker!

### build your own image

Instead of `pull`ing an image from the hub, you can `build` a custom one by creating a file called `Dockerfile` (no extension!) and putting the customization commands inside it as described [here](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/). For instance, you might want to pre-install additional julia packages or create an environment variable.

As a short example, start a new text file, call it `Dockerfile` and place the following lines in it:

```bash
# syntax=docker/dockerfile:1
FROM julia

RUN julia -e 'using Pkg; Pkg.add("Example")'

ENV twinprime=31
```

where the first commented out line is there for [docker reasons](https://docs.docker.com/engine/reference/builder/#syntax); `FROM julia` means the base image is 'julia' from the hub; `RUN ...` executes a bash command, in our case one installing package 'Example'; `ENV ...` sets an environment variable, in our case one called 'twinprime' with the value set to 31.

Finally, to build an image tagged 'julia-x' from your Dockerfile (located at `/path/to/Dockerfile`), use:

```bash
docker build -t "julia-x" /path/to/Dockerfile
```

This image, based on the off-the-shelf julia and tweaked slightly to include an additional package and an environment variable, can be used to run a container:

```bash
docker run julia-x julia -e 'using Example; println(hello(ENV["twinprime"]))'
```

Every time you want to introduce a change to the Dockerfile, make sure to rebuild the image, otherwise the containers run from it won't see those changes.

For inspiration and more useful lines to put into the Dockerfile, study the Dockerfile of images from Docker Hub; these are most often somewhere on GitHub and can be easily googled, e.g. 'julia dockerfile github', 'texlive dockerfile github' etc.

### file transfer

Containers have their own file structure which is isolated from that of the host, making file exchange tricky. Let us discuss three ways this can be achieved.

To transfer the same files to every container run from an image, use the Dockerfile as described [here](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#add-or-copy). This is most useful for setting up the coding environment from a configuration file or for copying project data files. The following line does the job:

```bash
COPY path/host/requirements.txt path/container/
```

To copy files to and from a *running* container, use `docker cp` command (multiple terminals might be needed). The exact procedure is described [here](tba).

A more advanced (and convenient) way of persisting files from a container is to use [mounts](tba).

### useful tricks

- remove all stopped containers
    `docker container prune`
- remove unused containers, networks, images
    `docker system prune`

## resources

- [`venv` docu](https://docs.python.org/3/library/venv.html)
- [`poetry` docu](https://python-poetry.org/docs/managing-environments/)
- [a good thread on `packrat`](https://stackoverflow.com/a/38949039/2835160)
- [`docker` docu](https://docs.docker.com)
- [a good unofficial `docker` guide](https://docker-curriculum.com/)
