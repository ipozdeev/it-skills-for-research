# writing with latex
<!-- TOC -->
<<<<<<< HEAD
- [introduction](#introduction)
- [terminology](#terminology)
=======
- [basics](#basics)
>>>>>>> 3cda812ab2856a875fda78d8f9186d3bef86e72d
- [setup](#setup)
  - [installation](#installation)
  - [packages](#packages)
  - [text editor](#text-editor)
- [overleaf](#overleaf)
- [workflow](#workflow)
- [document structure](#document-structure)
- [bibliography](#bibliography)
  - [structure](#structure)
  - [maintenance](#maintenance)
  - [implementation](#implementation)
- [useful tricks](#useful-tricks)
- [beamer](#beamer)
- [resources](#resources)
- [exercises](#exercises)
<!-- /TOC -->

## introduction
Any text document you encounter (including the one you are reading now) can be broken down into plain text and formatting.

Plain text is *what we write* &ndash; the content of the document. Formatted text on the other hand is *what we read* &ndash; the content plus the form, where the latter is chosen in a way as to allow the former to best serve its purpose. It is only rarely &ndash; e.g. as computer code or a manuscript fresh off of a typewriter &ndash; that the two coincide.

Separating content and form has many benefits (think of several yourself!) and is possible thanks to typesetting systems such as LaTeX. LaTeX workflow requires you to write plain text interspersed with formatting commands (which are but plain text themselves) using your favorite text editor, then merge the text and format by compiling the document using a TeX engine.

Note that this workflow is different from using a word processor such as MS Word or LibreOffice Writer which let you decide on the formatting and apply it on-the-fly. Although this might seem as a more convenient route, separating content from form is the serious-level standard and does result in better publications.

## terminology
When you say 'I am using LaTeX for my thesis', what you mean is that you are using a special system of commands called LaTeX to set the formatting of your thesis. These commands that you place here and there in the body of the text will be interpreted by a TeX engine to apply the formatting and produce a readable document. You can use a different system instead of LaTeX, but LaTeX is the predominant choice. Similarly, you can use one of many engines to execute the commands.

This way, LaTeX is what is called a *format*: a convenient collection of macros (programming instructions) written in the programming language called TeX. TeX has been around for years, but is a little too flexible and complex for everyday tasks, which is why people have collected many frequently used TeX macros, e.g. those that change fonts and insert hyperlinks, and bundled them together to produce LaTeX and other formats. Without the latter you would have to write TeX code for every piece of formatting.

A format alone is not enough: as mentioned previously an engine is also required. To name a popular one, *pdfLaTeX* would compile a document typeset in LaTeX to produce a pdf. 

For better typesetting experience, other software might come in handy, e.g. a bibliography formatter or graphics manipulation program. When all things necessary to transform an idea into a readable document are bundled together, a *TeX distribution* appears. Two distributions are currently maintained as open source: [MiKTeX](https://miktex.org/) and [TeX Live](https://www.tug.org/texlive/), but there are probably others maintained in corporations and universities. Of the two mentioned, [MiKTeX](https://miktex.org/) is claimed to be better optimized for Windows but to suffer from security problems; when on Linux or when security is key, [TeX Live](https://www.tug.org/texlive/) might be a better option.

Separate collections of macros designed to perform specific tasks (e.g. to insert a figure) within a specific format are called *packages*. These can be thought of as add-ons which fill a gap here and there.

See [resources](#resources) for more info.

## setup
The route from an idea to a .pdf goes as follows:
*   Write plain text consisting of the content and macros laying out the formatting;
*   Compile with an engine to apply the formatting.

As an illustration, we will be writing plain text in Sublime and using pdfLaTeX to compile it. Instead of executing commands in the console, we will rely on Sublime's LaTeXTools package which implements a builder that runs all the necessary commands for us. Feel free to use any other option.

### installation
A detailed guide for installing and configuring LaTeX and Sublime text can be found in the `/latex/configuring_latex_and_sublime_on_windows/` directory. A short summary for the MiKTeX part is below:

*   download MiKTeX Net Installer from [here](https://miktex.org/download), from tab 'All downloads';
*   run the installer, choose `Download MiKTeX`, then `Complete MiKTeX` when prompted;
*   run the installer again but this time choose `Install MiKTeX`, then `Complete MiKTeX`, then `Install MiKTeX for anyone who uses this computer`; in the `Install MiKTeX from` field choose the folder you previously downloaded the MiKTeX files to; choose to indeed `Install missing packages on-the-fly`;
*   (optional, but useful) [create a local TeXMF folder](https://tex.stackexchange.com/questions/69483/create-a-local-texmf-tree-in-miktex) &ndash; a folder where you would be able to manually install missing LaTeX packages.


### packages
There are two ways to install additional packages. The easy way is to use the package manager: open the MiKTeX console, navigate to tab `Packages` and type in the name of the package, then click the `+` button to install it. This works for most packages, e.g. [`threeparttable`](https://ctan.org/pkg/threeparttable?lang=en). 

Packages that are not available through the package manager &ndash; e.g. those written by nobody else but you and/or distributed as files with extension `.sty` &ndash; can still be installed manually, although the process is a bit trickier. Please see [this thread](https://tex.stackexchange.com/questions/2063/how-can-i-manually-install-a-package-on-miktex-windows) for reference.


### text editor
If you have not already, install Sublime and package [LaTeXTools](https://latextools.readthedocs.io/en/latest/) which gives you code completions, highlighting, inline preview, compiling from the editor and a great amount of control when LaTeXing in general.

You will also need to install [Sumatra PDF](https://www.sumatrapdfreader.org/free-pdf-reader.html) to use preview the produced .pdf files and inverse search a place in .tex from the corresponding place in .pdf. For instructions how to set up inverse search (from the .pdf to the .tex) see [here](https://latextools.readthedocs.io/en/latest/install/#windows).

Then, in the LaTeXTools package settings, navigate to section 'Build engine settings' and set 'builder' to 'basic'. Also, take time to read through what is written there. Basically, *building* is a bundle consisting of compiling the document, compiling the bibliography and producing the .pdf.

Optionally, install:
*   [ghostscript](https://ghostscript.com/download/gsdnld.html) to preview equations in Sublime Text;
*   [ImageMagick](http://www.imagemagick.org/script/download.php) to preview figures (don't forget to check the box `Add application directory to your system path`).

## overleaf
[Overleaf](https://www.overleaf.com/learn/how-to/Creating_a_document_in_Overleaf) is a great online tool allowing to create TeX documents. They have nice tutorials and tons of different templates and examples which you can modify and accommodate to your needs.

## workflow
1. **Know your macros**. You are aware which macros produce the formats you need and in which packages those macros are to be found. For instance, multi-line equations require package *amsmath* and are inserted as follows:
```latex
\begin{gather}
...
\end{gather}
```
2.  **Write text**. Write plain text using a text editor of choice (Notepad, Sublime, Atom etc.) inserting macros to set formatting. A document might look as simple as:
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
3.  **Build**. To turn your collection of text and macros into a readable document, the file must be compiled by running it through a program such as `latex` (will produce a .dvi file) or `pdflatex` (will produce a .pdf). From whenever your .tex file is located, execute the following in the command line:
```
pdflatex <filename>.tex
```
to produce a readable .pdf. In Sublime with LaTeXTools installed, you can use `Ctrl+B` to build.

Observe the separation here: you write the text, then compile it &ndash; which is tantamount to having the machine typeset it.

## document structure
LaTeX documents are expected to follows a certain layout. Please take a look at the [[latex wiki]](https://en.wikibooks.org/wiki/LaTeX/Document_Structure).

## bibliography
Bibliography is a collection of all references you cite in your work. As it is in general a bad idea to type citations by hand (there are too many of those, plus several other reasons), a better idea is to organize them in a well structured database and point to its entries whenever needed. In a LaTeX document, this is achieved using two things, which you will always encounter in discussions of bibliography: a backend processor such as _biber_ and a package providing bibliography formats such as _biblatex_. The former takes a bibliography database (usually a `.bib` file) and processes it to produce a TeX-conforming file (usually with extension `.bbl`), while the latter define macros used to place a citation, give a citation an ordinal number or create a hyperlink.

We will be working with _biber_ and _biblatex_. The latter contains many possible bibliography formats, e.g. `bwl-FU`.

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

Look up the bib guide in [resources](/resources) for a broad overview of the structure of .bib files.

### maintenance
Surely, it is too time-consuming to manually type in every one of hundreds of bibliography entries you want to cite. More often than not however, you would be able to find citation info in the same place as the cited piece. Look for 'Export to BibTeX' or 'Cite this item' or similar. For instance:

[https://www.nber.org/papers/w27638](https://www.jstor.org/stable/10.1086/605130 )
![figures/bibtex-file-loc-example-nber.png](figures/bibtex-file-loc-example-nber.png)

[https://www.jstor.org/stable/10.1086/605130](https://www.jstor.org/stable/10.1086/605130 )
![figures/bibtex-file-loc-example-jstor.png](figures/bibtex-file-loc-example-jstor.png)

`JabRef` is a nice little reference manager that helps the user collect and organize references. Among other things, it can boast an auto-collect feature based on document identifiers such as [*ISBN*](https://en.wikipedia.org/wiki/International_Standard_Book_Number) or [*DOI*](https://en.wikipedia.org/wiki/Digital_object_identifier). Take a look at the [user's guide](https://docs.jabref.org/) for more information.

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

## useful tricks
*   package `threeparttable` and environment `tablenotes`;
*   package `dcolumn` allowing to align columns on a separator, such as the decimal dot;
*   package `endfloat` to push all figures and table to the end.


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


## resources
*   [What LaTeX, TeX, pdflatex are all about](https://www.texfaq.org/FAQ-texthings);
*   [LaTeX learning resources](http://www.tug.org/begin.html) (all recommended);
*   [bibliography backend processors and packages](https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib);
*   [biblatex styles](https://tex.stackexchange.com/a/325099/218467);
*   [bib guide](https://www.economics.utoronto.ca/osborne/latex/BIBTEX.HTM);
*   [fantastic biblatex cheatsheet](http://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf);
*   [beamer examples with output](http://www2.informatik.uni-freiburg.de/~frank/ENG/latex-course/latex-course-3/latex-course-3_en.html).

## exercises
1.  Install MiKTeX;
2.  Setup Sublime Text for LaTeXing, including graphics preview and inverse search;
3.  Install, if not present already, packages `threeparttable` and `blindtext`;
4.  Create folder `text/` with subfloders `paper/` and `presentation/`;
5.  Install JabRef;
6.  Locate the DOI of Milgrom's paper 'A Theory of Auctions and Competitive Bidding' and use it to auto-parse the info to JabRef;
4.  Create a `.bib` file with two entries, a [published paper](https://www.journals.uchicago.edu/doi/10.1086/707735) and a [working paper](https://ssrn.com/abstract=3555917);
4.  Create a simple article consisting of:
    *   title page with title, author(s), affiliation(s), date, abstract and thanks;
    *   two pages of dummy text (use `blindtext` for that);
    *   two citations of the papers you added in step 5 above;
    *   a figure and a table, both with captions and notes;
    *   bibliography on a separate page.
5.  Create a simple beamer presentation consisting of:
    *   title frame with title, author(s), affiliation(s) and date;
    *   three frames with titles and subtitles;
    *   some equations and a theorem (use the special `theorem` environment);
    *   a figure with two panels.
