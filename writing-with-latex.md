# writing with latex
<!-- TOC -->

-   [basics](#basics)
-   [setup](#setup)
    -   [installation](#installation)
    -   [packages](#packages)
    -   [text editor](#text-editor)
-   [workflow](#workflow)
-   [document structure](#document-structure)
-   [bibliography](#bibliography)
    -   [structuring the database](#structuring-the-database)
    - [inserting the .bib database](#inserting-the-bib-database)
-   [useful tricks](#useful-tricks)
-   [resources](#resources)
-   [exercises](#exercises)

<!-- /TOC -->
## basics
LaTeX is a *typesetting system* used to translate plain text into pretty documents. It separates content and form, ecouraging the author to concentrate on the former, while letting the LaTeX handle the latter. You can think here of a standard author-publisher relation: Stephen King types a masterpiece on a typewriter not heedful of font sizes, header transparency, footnote separators or the like, then sends his manuscript to a publisher who handles all the above details.

> Is it a program, a language or what?

Sort of a program. It is a convenient collection of TeX macros used to format text, TeX being a lower-level typesetting system with an integrated macro scripting language. The whole game started with TeX many years ago, but for everyday use TeX is too much flexibility and too little user friendliness, so easier-to-use packaged pieces of TeX programming instructions started to appear, LaTeX being one of them. It contains pre-written routines you can use to change fonts, add section headers, insert hyperlinks etc &ndash; without LaTeX you would have to write TeX code for every such action. Collections like LaTeX are also called *formats*.

On a higher level still, there are *TeX distributions*, which are structured collections of stuff beyond a format someone thought you might need when typesetting. A typical TeX distribution such as *TeX Live* includes formats ( e.g. LaTeX), languages, many fonts, environments for specific tasks, helper programs such as bibliography formatters, pdf creators, even text editors and much more.

Separate collections of macros, usually serving one purpose, e.g. to insert a figure, are distributed as *packages*. Packages are add-ons which fill a gap here and there. One frequently used package is *graphicx*.

See [resources](#resources) for more info.

## setup
We will be using TeX Live distribution and write text in Sublime, compiling from within it.

### installation
*   Download [from here](https://www.tug.org/texlive/acquire-netinstall.html);
*   select 'medium' for scheme (~1.5 GB instead of 7 GB): 'medium' refers to the amount of packages known to the distribution creators that will be downloaded. Chances are high 'medium' will not be comprehensive enough for you;
*   test installation, see [here](https://www.tug.org/texlive/doc/texlive-en/texlive-en.html#x1-380003.5).

### packages
To install an additional package, you need to locate it in the distribution you are using (TeX Live in our case) first, e.g. package [`threeparttable`](https://ctan.org/pkg/threeparttable?lang=en).

Then, use either TeX Live Manager or
```
tlmgr install threeparttable
```
to install it, and do not forget to refresh the TeX database with
```
texhash
```

### text editor
If you have not already, install Sublime and package [LaTeXTools](https://latextools.readthedocs.io/en/latest/) which gives you code completions, highlighting, inline preview, compiling from the editor and a great amount of control when LaTeXing in general.

You will also need to install [Sumatra PDF](https://www.sumatrapdfreader.org/free-pdf-reader.html) to use preview the produced .pdf files and inverse search a place in .tex from the corresponding place in .pdf.

Then, in the LaTeXTools package settings, navigate to section 'Build engine settings' and set 'builder' to 'basic'. Also, take time to read through what is written there. Basically, *building* is a bundle consisting of compiling the document, compiling the bibliography and producing the .pdf.

## workflow
1. **Know your macros**. You are aware which macros produce the formats you need and in which packages those macros are to be found. For instance, multi-line equations require package *amsmath* and are inserted as follows:
```
\begin{gather}
...
\end{gather}
```
2.  **Write text**. Write plain text using a text editor of choice (Notepad, Sublime, Atom etc.) inserting macros to set formatting. A document might look as simple as:
```
\documentclass{article}
\usepackage{amsmath}
\begin{document}
\begin{gather}
	  x = 1 \\
	  y = -1
\end{gather}
\end{document}
```
3.  **Build**. To turn your collection of text and macros into a readable document, the file must be compiled by running it through a program such as `latex` (will produce a .dvi file) or `pdflatex` (will produce a .pdf). From whenever your .tex file is located, execute the following in the command line:
```
pdflatex <filename>.tex
```
to produce a readable .pdf. In Sublime with LaTeXTools installed, you can use `Ctrl+B` to build.

Observe the separation here: you write the text, then compile it &ndash; which is tantamount to having the machine typeset it.

## document structure
LaTeX documents are expected to follows a certaint layout. Please take a look at the [[latex wiki]](https://en.wikibooks.org/wiki/LaTeX/Document_Structure).

## bibliography
Bibliography is a collection of all references you cite in your work. As it is in general a bad idea to type citations by hand (there are too many of those, plus several other reasons), a better idea is to organize them in a well structured database and point to its entries whenever needed. In a LaTeX document, this is achieved using two things, which you will always encounter in discussions of bibliography: a backend processor such as _biber_ and a package providing bibliography formats such as _biblatex_. The former take a bibliography database (usually a .bib file) and process it to produce a .tex-like file, while the latter define macros used to place a citation, give a citation an ordinal number or create a hyperlink.

We will be working with _biber_ and _biblatex_. The latter contains many possilbe bibliography formats, e.g. 'bwl-FU'.

### structuring the database
A bibliography database is saved as a .bib file and has entries of the form:
```
@<TYPE>{<KEY>,
  <FIELD> = {<FIELD_VALUE>},
}
```
where
*   `<TYPE>` is the type of the source, most commonly `article` or `book`,
*   `<KEY>` is the unique identifier of this entry to be used in text, most commonly a short memorizable string such as `cieslak2019stock` which refers to the paper by Cieslak, Morse and Vissing-Jorgensen called 'Stock returns over the FOMC cycle' published in 2019;
*   `<FIELD>` is the name of one of many fields containing information about the source, e.g. `title` and `journal`;
*   `<FIELD_VALUE>` is the field value.

Look up the bib guide in [resources](/resources) for a broad overview of the structure of .bib files.

### inserting the .bib database
Place biblatex package import statement in the [preamble](https://en.wikibooks.org/wiki/LaTeX/Document_Structure) of the document, not forgetting to specify the parameters:
```
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

## useful tricks
* package `threeparttable` and environment `tablenotes`;
* package `dcolumn` allowing to align columns on a separator, such as the decimal dot;
* package `endfloat` to push all figures and table to the end.

## resources
* [What LaTeX, TeX, pdflatex are all about](https://www.texfaq.org/FAQ-texthings);
[* LaTeX learning resources](http://www.tug.org/begin.html) (all recommended);
* [bibliography backend processors and packages](https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib);
* [biblatex styles](https://tex.stackexchange.com/a/325099/218467);
* [bib guide](https://www.economics.utoronto.ca/osborne/latex/BIBTEX.HTM);
* [fantastic biblatex cheatsheet](http://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf).

## exercises
1.   TODO
