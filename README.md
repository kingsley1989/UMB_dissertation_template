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

## Issue with the table of content 

If you have to add word *Chapter/Table/Figure* and *Page* on the second page of toc, tot or tof, add the following code to the end of `example/chapters/headpages.tex`

    \addtocontents{toc}{\protect\afterpage{\textbf{CHAPTER\hfill Page}\par\medskip}}
    \addtocontents{lot}{\protect\afterpage{\textbf{~\\Table \hfill Page}\par\medskip}}
    \addtocontents{lof}{\protect\afterpage{\textbf{~\\Figure \hfill Page}\par\medskip}}

If you have three or more pages of toc, tot or tof, just repeat the above commands, respectively. You don't need to add these commands, if you only have one page.

## Policies and forms for theses and dissertations of UMASS Boston 
- [Standards for the Preparation of Theses and Dissertations at the University of Massachusetts Boston [PDF - last updated November 4, 2019]](https://www.umb.edu/editor_uploads/images/graduate_studies/Revised_Standards_November_19.pdf)
- [How to Submit Your Thesis or Dissertation using UMass Boston/ProQuest ETD - A Step-by-Step Guide](https://www.umb.edu/editor_uploads/images/graduate_studies/Step_by_Step_throug5BD377_2016.docx)

## See also

More information of the parameter of the class can refer to the original source of [UMass Amerst](https://github.com/umasscs/umassthesis).
