# UMB_dissertation_template
This is the unofficial LaTex templete for the PhD and Master Dissertation of the Department of Computer Science, University of Massachusetts Boston

## Source
This templete is a modification of an unofficial templete of UMass Amerst from [https://github.com/umasscs/umassthesis](https://github.com/umasscs/umassthesis)

## Installation
The installation is the same as the UMass Amerst Templete.

Please Run the install.sh file to install the package.

    ./install.sh
    
Once installed, you should be able to work with the example files in `example/`:

    cd example/
    # Compile with pdflatex + bibtex:
    pdflatex thesis
    bibtex thesis
    pdflatex thesis

## Issue with the talbe of content 

If you have to add word *Chapter/Table/Figure* and *Page* on the second page of toc, tot or tof, add the following code to the end of `example/chapters/headpages.tex`

    \addtocontents{toc}{\protect\afterpage{\textbf{CHAPTER\hfill Page}\par\medskip}}
    \addtocontents{lot}{\protect\afterpage{\textbf{~\\Table \hfill Page}\par\medskip}}
    \addtocontents{lof}{\protect\afterpage{\textbf{~\\Figure \hfill Page}\par\medskip}}

If you have three or more pages of toc, tot or tof, just repeat the above commands, respectively. You don't need to add these commands, if you only have one page.

## See also

More information of the parameter of the class can refer to the original source of [UMass Amerst](https://github.com/umasscs/umassthesis).