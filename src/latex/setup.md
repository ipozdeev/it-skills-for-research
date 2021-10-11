# LaTeX installation and Sublime setup guide (Windows)

This guide covers installation and configuration of LaTeX and Sublime Text and on Windows (tested on Windows 10 / x64).

1. Follow the instructions to install MiKTeX: [https://miktex.org/howto/install-miktex](https://miktex.org/howto/install-miktex);

2. Make sure you can run LaTeX commands e.g. `pdflatex --help` in the command line;

3. Download and install Sumatra PDF: [https://www.sumatrapdfreader.org/download-free-pdf-viewer](https://www.sumatrapdfreader.org/download-free-pdf-viewer) &ndash; needed to preview compiled .pdf files from Sublime;

the following two items are optional (for somewhat improved latexing experience, e.g. equations preview) and safe to skip:

4. Download and install ghostscript: [https://ghostscript.com/download/gsdnld.html](https://ghostscript.com/download/gsdnld.html);

5. Download and install ImageMagick: [http://www.imagemagick.org/script/download.php](http://www.imagemagick.org/script/download.php) (don't forget to check the box `Add application directory to your system path`);

in Sublime:

6. Install package 'LaTeXTools' as described in the installation guide: [https://latextools.readthedocs.io/en/latest/install/](https://latextools.readthedocs.io/en/latest/install/)

7. Go to `Preferences -> Package Settings -> LaTeXTools` and select `Check System`. You should see something like this:

<img src="setup-src/check_results.png" width="900"/>

If some components are missing, make sure that their respective executables are added to the `PATH` system variable.

8. In the LaTeXTools package settings, navigate to section 'Build engine settings' and set 'builder' to 'basic'. Also, take time to read through what is written there. Basically, *building* is a bundle consisting of compiling the document, compiling the bibliography and producing the .pdf.