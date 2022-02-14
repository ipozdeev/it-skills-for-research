# writing with latex

<!-- TOC -->

- [writing with latex](#writing-with-latex)
  - [introduction](#introduction)
  - [terminology](#terminology)
  - [setup](#setup)
  - [packages](#packages)
    - [useful packages](#useful-packages)
  - [workflow](#workflow)
  - [generating .tex exogenously](#generating-tex-exogenously)
  - [bibliography](#bibliography)
    - [structure](#structure)
    - [maintenance](#maintenance)
    - [implementation](#implementation)
  - [beamer](#beamer)
  - [custom classes and packages](#custom-classes-and-packages)
  - [resources](#resources)
  - [exercises](#exercises)

<!-- /TOC -->


## introduction
Any text document you encounter (including the one you are reading now) is a combination of plain text and formatting.

Plain text is *what we write* &ndash; the content of the document. Formatted text on the other hand is *what we read* &ndash; the content plus the form, where the latter is chosen in a way as to allow the former to best serve its purpose. It is only rarely &ndash; e.g. as computer code or a manuscript fresh off of a typewriter &ndash; that the two are the same.

Separating content and form has many benefits (think of several yourself) and is possible thanks to typesetting systems such as LaTeX. LaTeX workflow requires you to write plain text interspersed with formatting commands (which are but plain text themselves) using your favorite text editor, then merge the text and formatting by compiling the document with a TeX engine.

Note that this workflow is different from using a word processor such as MS Word or LibreOffice Writer which make you apply the formatting on the fly. Although this might seem as a more convenient route, separating content from form is the serious-level standard and does result in better publications.


## terminology
For someone to be 'using LaTeX for the thesis' means to be using a special system of commands called LaTeX to set the formatting of the thesis's text. These commands placed here and there in the `.tex` file will be interpreted by a TeX compiler (aka engine) to apply the formatting and produce a readable document. LaTeX is not the only such system, but the most popular one. Similarly, there are several TeX engines to interpret the commands.

LaTeX is what is called a *format*: a convenient collection of macros (programming instructions) written in the programming language called TeX. TeX has been around for years, but is a little too flexible and complex for everyday tasks, which is why people have collected many frequently used TeX macros, e.g. those that change fonts and insert hyperlinks, and bundled them together to produce LaTeX and other formats. Without the latter you would have to write TeX code for every piece of formatting.

A format alone is not enough: as mentioned previously an engine is also required. To name a popular one, *pdfLaTeX* would compile a document typeset in LaTeX to produce a pdf.

For better typesetting experience, other software might come in handy, e.g. a bibliography formatter or graphics manipulation program. When all things necessary to transform an idea into a readable document are bundled together, a *TeX distribution* appears. Two distributions are currently maintained as open source: [MiKTeX](https://miktex.org/) and [TeX Live](https://www.tug.org/texlive/), but there may be others circulating in the private sector. Of the two mentioned, [MiKTeX](https://miktex.org/) is claimed to be better optimized for Windows but to suffer from security problems; when on Linux or when security is key, TeX Live might be a better option.

Separate collections of macros designed to perform specific tasks (e.g. to insert a figure) within a specific format are called *packages*. These can be thought of as add-ons filling a gap here and there.

See [resources](#resources) for more info.


## setup
To get latexing up and running we would need a format, an engine, a bibliography processor (to be discussed later) and a text editor. Here, we will use LaTeX, pdfLaTeX, biber and Sublime Text with the excellent LaTeXTools package respectively, but feel free to use your own favorites instead.

Install and configure LaTeX and Sublime Text + LaTeXTools package as outlined in [setup guide](src/latex/setup.md).

[Overleaf](https://www.overleaf.com/learn/how-to/Creating_a_document_in_Overleaf) is a great option: it is an online tool for learning TeX and creating documents. It features tons of different templates and examples which you can modify and accommodate to your needs.


## packages
If you would like to install a missing package, e.g. [`threeparttable`](https://ctan.org/pkg/threeparttable?lang=en), google it first. Almost all packages you will ever need are registered on [CTAN](https://ctan.org/); in this case, check if the package is contained in your distribution:

<img src="src/latex/package-on-ctan.png" width="500"/>

With some luck, you would be able to install it the easy way through the package manager: open the MiKTeX console, navigate to tab `Packages` and type in the name of the package as it appears under 'Contained in' on CTAN, then click the `+` button to install it.

Packages that are not available through the package manager &ndash; e.g. those written by you and/or distributed as files with extension `.sty` &ndash; can still be installed manually, although the process is a bit trickier. Please see [this thread](https://tex.stackexchange.com/questions/2063/how-can-i-manually-install-a-package-on-miktex-windows) for instructions.


### useful packages
*   package `threeparttable` and environment `tablenotes`;
*   package `dcolumn` allowing to align columns on a separator, such as the decimal dot;
*   package `endfloat` to push all figures and table to the end (please avoid it).


## workflow
1. **Know your macros**. You are aware which macros produce the formats you need and in which packages those macros are to be found. For instance, multi-line equations require package *amsmath* and are inserted as follows:
```latex
\begin{gather}
...
\end{gather}
```

2.   **Follow the layout**. LaTeX documents are expected to be rigidly structured: please take a look at the [latex wiki](https://en.wikibooks.org/wiki/LaTeX/Document_Structure).

3.  **Write text**. Write plain text inserting macros to set formatting. A document might look as simple as:
```latex
\documentclass{article}
\usepackage{amsmath}
\begin{document}
\begin{gather}
	  x = 1 \\
	  y = -1
\end{gather}
\end{document}
```

4.  **Compile**. To turn your collection of text and macros into a readable document, the file must be compiled using an engine such as `latex` (will produce a `.dvi` file) or `pdflatex` (will produce a pdf). From whenever your `.tex` file is located, execute the following in the command line:
```
pdflatex <filename>.tex
```
to produce a readable pdf. In Sublime with LaTeXTools installed, you can use `Ctrl+B` instead. Do read more about compilers [here](https://www.overleaf.com/learn/latex/Choosing_a_LaTeX_Compiler).


## generating .tex exogenously
Often, you can use the same software that generates your research findings such as tables and figures to *latexify* them, or transcribe to LaTeX-interpretable code. It might be a function such as `xtable` in R, a method of a class, such as `pandas.DataFrame.to_latex()` in python or a button in the navigation bar as in gretl. In any case, before starting to manually input numbers into a .tex file, do search for a solution first! For instance:

> [julia write table to latex](https://korsbo.github.io/Latexify.jl/stable/)

> [jupyter notebook export to latex](https://stackoverflow.com/questions/32564415/how-to-convert-jupyter-ipython-notebooks-to-latex)


## bibliography
Bibliography is a collection of all references you cite in your work. As it is in general a bad idea to type citations by hand (at the bare minimum to avoid awkward spelling errors), a better idea is to organize them in a well structured database and point to its entries whenever needed. In a LaTeX document, this is achieved using two things, which you will always encounter in discussions of bibliography: a backend processor such as _biber_ and a package providing bibliography formats such as _biblatex_. The former takes a bibliography database (usually a `.bib` file) and processes it to produce a TeX-conforming file (usually with extension `.bbl`), while the latter uses a format's macros to place, point to and and keep track of citations.

<!-- TODO: how does biber work? -->

We will be working with *biber* and *biblatex*. The latter contains many possible bibliography variants such as `bwl-FU`, differing in the way names are abbreviated and ordered, mnemonics defined etc.

### structure
A bibliography database is saved as a `.bib` file and has entries of the form:
```latex
@<TYPE>{<KEY>,
  <FIELD> = {<FIELD_VALUE>},
}
```
where
*   `<TYPE>` is the type of the source, most commonly `article`, `techreport` or `book`,
*   `<KEY>` is the unique identifier of this entry to be used in text, most commonly a short memorizable string such as `cieslak2019stock` which refers to the paper by Cieslak, Morse and Vissing-Jorgensen called 'Stock returns over the FOMC cycle' published in 2019;
*   `<FIELD>` is the name of one of many fields containing information about the source, e.g. `title` and `journal`;
*   `<FIELD_VALUE>` is the field value.

Look up the bib guide in [resources](/resources) for a broad overview of the structure of `.bib` files.

### maintenance
Surely, it is too time-consuming to manually type in every one of hundreds of bibliography entries you want to cite. More often than not however, you would be able to find citation info in the same place as the cited piece. Look for 'Export to BibTeX' or 'Cite this item' or similar. For instance:

[https://www.nber.org/papers/w27638](https://www.nber.org/papers/w27638)

<img src="src/latex/bibtex-file-loc-example-nber.png" width="500"/>

or

[https://www.jstor.org/stable/10.1086/605130](https://www.jstor.org/stable/10.1086/605130 )

<img src="src/latex/bibtex-file-loc-example-jstor.png" width="500"/>

*JabRef* is a nice little reference manager that helps the user collect and organize references. Among other things, it can boast an auto-collect feature based on document identifiers such as [*ISBN*](https://en.wikipedia.org/wiki/International_Standard_Book_Number) or [*DOI*](https://en.wikipedia.org/wiki/Digital_object_identifier). Take a look at the [user's guide](https://docs.jabref.org/) for more information.

### implementation
Place biblatex package import statement in the [preamble](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Preamble) of the document, not forgetting to specify the parameters:
```latex
% bibliography
\usepackage[
    backend=biber,
    style=bwl-FU,
    url=false,
    doi=false,
    eprint=false
]{biblatex}
\addbibresource{<bibliography_name>.bib}
```

And to print the bibliography, put
```latex
\printbibliography
```
where it is supposed to appear.


## beamer
Package `beamer` provides functionality to create presentations with LaTeX. You should now be able to guess what it does: through a plethora of macros, it redefines the geometry of the canvas to have the usual 'presentation' aspect ratio (4:3) and size of print-outs (128x96mm), allocates one page per frame, creates titles and subtitles, meaningful footers etc. A simplest layout of a beamer-style presentation is as follows:
```
\documentclass[10pt]{beamer}

\begin{document}

\author{your name goes shere}

% ---------------------------------------------------------------------------
\begin{frame}
\titlepage
\end{frame}
% ---------------------------------------------------------------------------

\end{document}

```
More elaborate examples are in the [package documentation](https://ctan.org/pkg/beamer?lang=en).


## custom classes and packages
If you are not happy with off-the-shelf solutions LaTeX has to offer or have a strong preference for individuality in design, you can write your own packages and classes and `\usepackage{}` or `\documentclass{}` them in the preamble of the document. [Here](https://www.overleaf.com/learn/latex/Understanding_packages_and_class_files) is a short explanation when to use which. A frequent reason to write a `.cls` is indeed:
> [...] if a company needs branded reports that use a special font and have the logo of the company in the footer; you need a new class.


## resources
*   [LaTeX learning resources](http://www.tug.org/begin.html) (all recommended);
*   [what LaTeX, TeX, pdflatex are all about](https://www.texfaq.org/FAQ-texthings);
*   [compilers?](https://www.overleaf.com/learn/latex/Choosing_a_LaTeX_Compiler)
*   [bibliography backend processors and packages](https://tex.stackexchange.com/a/25702/218467);
*   [biblatex styles](https://tex.stackexchange.com/a/325099/218467);
*   [bib guide](https://www.economics.utoronto.ca/osborne/latex/BIBTEX.HTM);
*   [fantastic biblatex cheatsheet](http://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf);
*   [beamer examples with output](http://www2.informatik.uni-freiburg.de/~frank/ENG/latex-course/latex-course-3/latex-course-3_en.html).

## exercises
1.  Install MiKTeX;
2.  Setup Sublime Text for LaTeXing, including graphics preview and inverse search;
3.  Install, if not present already, packages `threeparttable` and `blindtext`;
4.  Create folder `text/` with subfloders `paper/`, `presentation/` and `playground/`;
5.  In folder `playground/`, write 4 lines of code producing a document with the single sentence 'my first line';
6.  Compile the above document with `pdflatex`;
5.  Install JabRef;
6.  Locate the DOI of Milgrom's paper 'A Theory of Auctions and Competitive Bidding' and use it to auto-parse the info to JabRef;
4.  Create a `.bib` file with two entries, a [published paper](https://www.journals.uchicago.edu/doi/10.1086/707735) and a [working paper](https://ssrn.com/abstract=3555917);
4.  Create a simple article consisting of:
    *   title page with title, author(s), affiliation(s), date, abstract and thanks;
    *   two pages of dummy text (use `blindtext` for that);
    *   two citations of the papers you added above;
    *   a figure and a table, both with captions and notes;
    *   bibliography on a separate page.
5.  Create a simple beamer presentation consisting of:
    *   title frame with title, author(s), affiliation(s) and date;
    *   three frames with titles and subtitles;
    *   some equations and a theorem (use the special `theorem` environment);
    *   a figure with two panels.
