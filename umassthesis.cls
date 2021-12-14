%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  UMass Boston Thesis Class
%%
%%   Modification on the templete of UMass Amherst.
%%   Based on merging a version from Jamie Callan/Carla Brodley
%%   with the Utah version that has also been floating around.
%%
%%      Makes adjustments to the basic REPORT document style
%%      Size selected in documentstyle must be 12pt
%%              (see thesis.tex in this directory for usage example)
%%
%%  Author: 
%%  Tony Hosking, 1995, original file and idea
%%  John Ridgway, 1997, turned into a class file and rewritten
%%  Kaixun Hua, 2019, Modified to fit UMass Boston Thesis Requirements
%%  YOng  Zhuang, 2021, Modified to fit UMass Boston Thesis Requirements
%%
%%  umthesis.cls,v 1.25 2003/10/16 20:20:51 ridgway Exp
%%  umthesis.cls,v
%%  Revision 1.25  2003/10/16 20:20:51  ridgway
%%  Make umthesis work with the natbib package, and clean up some miscellaneous
%%  formatting things.
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Identification part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umassthesis}[2014/04/16 v1.26
                         U.Mass. dissertation class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifdouble@space
\newif\ifcondensed@frontmatter
\newif\ifnicer@draft
\newif\if@proposal\@proposalfalse
\newcommand{\@degree}{Doctor of Philosophy}
\newcommand{\@degreeabbrv}{Ph.D.}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Declaration of options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{10pt}{\def\@mysize{10pt}}
\DeclareOption{11pt}{\def\@mysize{11pt}}
\DeclareOption{12pt}{\def\@mysize{12pt}}
\DeclareOption{singlespace}{\double@spacefalse}
\DeclareOption{doublespace}{\double@spacetrue}
\DeclareOption{condensed}{\condensed@frontmattertrue\double@spacefalse}
\DeclareOption{uncondensed}{\condensed@frontmatterfalse}
\DeclareOption{proposal}{\def\umassthesis@typename{A Dissertation Outline}\@proposaltrue}
\DeclareOption{dissertation}{\def\umassthesis@typename{A Dissertation}}
\DeclareOption{thesis}{\def\umassthesis@typename{A Thesis}%
  \renewcommand{\@degree}{Master of Science}%
  \renewcommand{\@degreeabbrv}{M.S.}}
\DeclareOption{nolisthyphenation}{\def\umassthesis@listhyphenpenalty{10000}}
\DeclareOption{allowlisthyphenation}{\def\umassthesis@listhyphenpenalty{50}}
\DeclareOption{nicerdraft}{\nicer@drafttrue}
\DeclareOption{nonicerdraft}{\nicer@draftfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Execution of options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ExecuteOptions{12pt,doublespace,uncondensed,dissertation,%
                nolisthyphenation,nonicerdraft}
\ProcessOptions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[\@mysize]{report}[1996/01/02]
\RequirePackage{textcase}
\RequirePackage{etoolbox}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Post-package-loading fixups.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\input{umth\@mysize.clo}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\toc@section}{Chapter}

\newcounter{count@FrontMatter}
\newcounter{count@Chapter}
\newcounter{count@Appendix}
\newcounter{count@BackMatter}

\AtEndDocument{%
  \immediate\write\@mainaux{\string\setcounter{count@FrontMatter}%
    {\arabic{count@FrontMatter}}}%
  \immediate\write\@mainaux{\string\setcounter{count@Chapter}%
    {\arabic{count@Chapter}}}%
  \immediate\write\@mainaux{\string\setcounter{count@Appendix}%
    {\arabic{count@Appendix}}}%
  \immediate\write\@mainaux{\string\setcounter{count@BackMatter}%
    {\arabic{count@BackMatter}}}%
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Major document structure, \frontmatter, \mainmatter, \appendix, \backmatter

\newcommand{\frontmatter}{
  \setcounter{secnumdepth}{-1}
  \renewcommand{\toc@section}{FrontMatter}
  \setcounter{count@FrontMatter}{0}
  \ifdouble@space\doublespacenormalsize\fi
  }

\newcommand{\mainmatter}{
  \setcounter{secnumdepth}{5}
  \clearpage
  \pagenumbering{arabic}          % Arabic numbers from here on
  \raggedbottom
  \ifdouble@space\doublespacenormalsize\fi
  \renewcommand{\toc@section}{Chapter}
  \setcounter{count@Chapter}{0}
  }

\renewcommand{\appendix}{
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}
  \renewcommand{\toc@section}{Appendix}
  \ifnum\value{count@Appendix}<2
    \let\@chapter\@onlyappendix
  \fi
  \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}%
  \setcounter{count@Appendix}{0}
  }

\newcommand{\backmatter}{
  \setcounter{secnumdepth}{5}
  \renewcommand{\@chapapp}{\chaptername}
  \renewcommand{\toc@section}{BackMatter}
  \let\@chapter\normal@chapter
  \setcounter{count@BackMatter}{0}
  \normalsize
  }

\def\@onlyappendix[#1]#2{%
  \refstepcounter{chapter}%
  \typeout{\@chapapp.}%
  \addcontentsline{toc}{OnlyAppendix}{\MakeTextUppercase{#1}}%
  \chaptermark{#1}%
  \if@twocolumn%
    \@topnewpage[\@makeonlyappendixhead{#2}]%
  \else%
    \@makeonlyappendixhead{#2}%
    \@afterheading%
  \fi%
  \renewcommand{\thesection}{A.\@arabic\c@section}
  \stepcounter{count@\toc@section}
 }

\def\@makeonlyappendixhead#1{%
  { \def\thechapter{} \@makechapterhead{#1} } }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part related stuff

%% redefine @part to change toc entries
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \hspace*{\fill}\par
      \centering {\large\bfseries #1}\par
      \leavevmode \hspace*{\fill} \par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{{\MakeUppercase{\partname\nobreakspace\thepart {:}}}\hspace{1em}{\MakeUppercase{#1}}}%
    \else
      \centering{part}{#1}%
    \fi
    \markboth{}{}%
    {\thispagestyle{empty}
     \centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries {\MakeUppercase{\partname}}\nobreakspace\thepart : \nobreakspace{\MakeUppercase{#2}}
       \par
       \vskip 20\p@
     \fi
     }
     %\Huge \bfseries {\MakeUppercase{#2}}\par}%
    \@endpart}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter/Appendix related stuff

\newcommand{\unnumberedchapter}[2][]{
  \def\@tempa{#1}
  \def\@tempb{}
  \ifx\@tempa\@tempb
    \def\@tempc{#2}
  \else
    \def\@tempc{#1}
  \fi
  \chapter*{#2}
  \addcontentsline{toc}{\toc@section}{\MakeTextUppercase{\@tempc}}
}

% Patch \@chapter to change TOC entries.  The original code appears to:
%  (1) replace '\numberline{\thechapter}#1' with
%      '\numberline{\thechapter.}\MakeTextUppercase{#1}'
%  (2) replace '{toc}{chapter}{#1}' with
%      '{toc}{\toc@section}{\MakeTextUppercase{#1}}'
%  (3) replace '{toc}{chapter}' with '{toc}{\toc@section}'
%  (4) append '\stepcounter{count@\toc@section}'

% Disable uppercase when making PDF strings...this breaks hyperref
\AtEndPreamble{%
  \@ifpackageloaded{hyperref}%
    {\pdfstringdefDisableCommands{%
      \let\MakeTextUppercase\relax%
      \let\uppercase\relax}%
     \typeout{Disabled uppercase in PDF strings}}%
    {\typeout{Did not detect hyperref package}}%
  }

% For debugging:
%\tracingpatches
%\ifpatchable*{\@chapter}{\typeout{Chapter can be patched}}%
%  {\typeout{Chapter cannot be patched}}
\patchcmd{\@chapter}%
  {\numberline{\thechapter}#1}%
  {\numberline{\thechapter.}\MakeTextUppercase{#2}}%
  {\typeout{Patching chapter command 1 succeeded}}%
  {\typeout{Patching chapter command 1 failed}}
\patchcmd{\@chapter}%
  {\addcontentsline{toc}{chapter}{#1}}%
  {\addcontentsline{toc}{\toc@section}{\MakeTextUppercase{#1}}}%
  {\typeout{Patching chapter command 2 succeeded}}%
  {\typeout{Patching chapter command 2 failed}}
\patchcmd{\@chapter}%
  {\addcontentsline{toc}{chapter}}%
  {\addcontentsline{toc}{\toc@section}}%
  {\typeout{Patching chapter command 3 succeeded}}%
  {\typeout{Patching chapter command 3 failed}}
\apptocmd{\@chapter}%
  {\stepcounter{count@\toc@section}}%
  {\typeout{Appending to chapter command succeeded}}%
  {\typeout{Appending to chapter command failed}}

\newif\ifrenew@chapter
\ifdouble@space%
  \renew@chaptertrue%
\else%
  \ifnicer@draft%
    \renew@chapterfalse%
  \else%
    \renew@chaptertrue%
  \fi%
\fi
\ifrenew@chapter%
  \renewcommand\chapter{%
    \if@openright\cleardoublepage\else\clearpage\fi%
    \thispagestyle{plain}%
    \@afterindenttrue%
    \global\@topnum\z@%
    \secdef\@chapter\@schapter%
  }%
\fi

\renewcommand{\@makechapterhead}[1]{    % Heading for \chapter command
  \vspace*{30\p@}                       % Space at top of text page.
  \begin{center}\large\bfseries
    \ifnum \c@secnumdepth >\m@ne
      \MakeTextUppercase\@chapapp\ \thechapter % 'CHAPTER' and number.
      \par\nobreak
    \fi
  \addvspace{\topskip}
  \MakeTextUppercase{#1}
  \end{center}
  \par\nobreak                          % TeX penalty to prevent page break.
  \vskip 14\p@                          % Space between title and text.
  }

\let\base@schapter\@schapter
\def\@schapter#1{
  \base@schapter{#1}
  \stepcounter{count@\toc@section}
  }

\renewcommand{\@makeschapterhead}[1]{   % Heading for \chapter* command
  \vspace*{30\p@}                       % Space at top of page.
  \begin{center}
    \large\bfseries                     % Title.
    \MakeTextUppercase{#1}\par
  \end{center}
  \nobreak                              % TeX penalty to prevent page break.
  \vskip 14\p@                          % Space between title and text.
  }

\let\normal@chapter\@chapter %% save the chapter


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak penalties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%\hyphenpenalty=400
%%\exhyphenpenalty=400

\clubpenalty=10000              % 'Club line'  at bottom of page.
\widowpenalty=10000             % 'Widow line' at top of page.
\displaywidowpenalty=3000       % Math display widow line.
\predisplaypenalty=3000         % Breaking before a math display.
\postdisplaypenalty=2000        % Breaking after a math display.

%% Do these need tweaking too?
%%\interlinepenalty               % Breaking at a line within a paragraph.
%%\brokenpenalty                  % Breaking after a hyphenated line.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak table of contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\tableofcontents}{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \normalsize
    \chapter*{\contentsname
        \@mkboth{%
           \MakeTextUppercase\contentsname}{\MakeTextUppercase\contentsname}}%
    %{\hfill \textbf{Page}\par}%
    {\hyphenpenalty=\umassthesis@listhyphenpenalty\@starttoc{toc}}%
    \if@restonecol\twocolumn\fi
    }

\renewcommand{\contentsname}{Table of Contents}

\def\thetocindent{-1}
\newif\if@seenChapter
\newif\if@seenAppendix
\newif\if@seenBackMatter
\@seenChapterfalse
\@seenAppendixfalse
\@seenBackMatterfalse

\renewcommand{\@dotsep}{2}

\newlength{\umassthesis@contentshangindent}
\setlength{\umassthesis@contentshangindent}{0.55em}%indent for wrap title on second line

\renewcommand{\@dottedtocline}[5]{%
  \ifnum #1>\c@tocdepth \else
    \ifnum \thetocindent = #1 \else
      \def\thetocindent{#1}
      \ifdouble@space\addvspace{\topskip}\fi
    \fi
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \advance\rightskip by 0pt plus 1fil\relax% ragged-right contents...
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     \hangindent\umassthesis@contentshangindent
     {#4}\nobreak%
     \leaders\hbox{$\m@th\mkern \@dotsep mu \hbox{.}\mkern \@dotsep mu$}%
             \hskip3em plus1fill\relax%
       \normalfont \normalcolor #5%
     \par}%
  \fi}


\newcommand{\l@FrontMatter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }
  
\newcommand{\l@Chapter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \if@seenChapter\else
    \addvspace{2\baselineskip}
    \parindent\z@ {\bfseries \MakeTextUppercase{\chaptername}\hfill Page} \par
    
    \addvspace{\baselineskip}
    \@seenChaptertrue
  \fi
  \@dottedtocline{1}{1.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }
\renewcommand{\l@section}[1]{
 \@dottedtocline{1}{2.5em}{2.5em}{\bfseries #1}
 }
\renewcommand{\l@subsection}[1]{
 \@dottedtocline{1}{5.0em}{3em}{\bfseries #1}
 }
\renewcommand{\l@subsubsection}[1]{
 \@dottedtocline{1}{8em}{4em}{\bfseries #1}
 }


\newcommand{\appendicesname}{APPENDICES}

\newcommand{\l@Appendix}[2]{
  \addpenalty{-\@highpenalty}
  \if@seenAppendix\else
    \addvspace{2\baselineskip}
    \parindent\z@ {\bfseries \appendicesname} \par

    \addvspace{\baselineskip}
    \@seenAppendixtrue
  \fi
  \@dottedtocline{0}{1.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }

\newcommand{\l@OnlyAppendix}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{2\baselineskip}
  \parindent\z@
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries
    \MakeTextUppercase{\appendixname}: #1}{\bfseries #2}
  }

\newcommand{\l@BackMatter}[2]{
  \addpenalty{-\@highpenalty}
  \addvspace{\baselineskip}
  \if@seenBackMatter\else
    \addvspace{2\baselineskip}
    \@seenBackMattertrue
  \fi
  \@dottedtocline{0}{0.0em}{1.5em}{\bfseries #1}{\bfseries #2}
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tweak lists of tables and figures
%%
\newlength{\tablenumberwidth}
\setlength{\tablenumberwidth}{2.3em}
\ifcondensed@frontmatter
  \renewcommand{\listoffigures}{}
\else
  \renewcommand{\listoffigures}{%
    \setcounter{tocdepth}{3}
    \normalsize
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter{\listfigurename
      \@mkboth{\MakeTextUppercase\listfigurename}%
              {\MakeTextUppercase\listfigurename}}%
    %{\normalsize\parindent\z@\textbf{Figure \hfill Page}\par}%
    {\hyphenpenalty=\umassthesis@listhyphenpenalty\@starttoc{lof}}%
    \if@restonecol\twocolumn\fi
    }
\fi
\renewcommand{\l@figure}[2]{
  \addvspace{\baselineskip}
  \@dottedtocline{1}{1.5em}{\tablenumberwidth}{#1}{#2}
  }

\ifcondensed@frontmatter
  \renewcommand{\listoftables}{}
\else
  \renewcommand{\listoftables}{%
    \setcounter{tocdepth}{3}
    \normalsize
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter{\listtablename
      \@mkboth{%
          \MakeTextUppercase\listtablename}{\MakeTextUppercase\listtablename}}%
    %{\normalsize\parindent\z@\textbf{Table \hfill Page}\par}%
    {\hyphenpenalty=\umassthesis@listhyphenpenalty\@starttoc{lot}}%
    \if@restonecol\twocolumn\fi
    }
\fi
\let\l@table\l@figure

\let\umassthesis@base@starttoc\@starttoc
\renewcommand{\@starttoc}{\tolerance10000\umassthesis@base@starttoc}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Page layout -- as required
%%

\setlength{\oddsidemargin}{0.25truein}  % binding margin(left) at least 1.25in
\setlength{\evensidemargin}{0.25truein} % same as odd side
\setlength{\textwidth}{6.0truein}      % 6in wide typing area
\setlength{\topmargin}{-0.5truein} % page numbers at top of page 0.5in from top
\setlength{\headheight}{0.2truein} % room for header
\setlength{\headsep}{0.3truein}    % header 0.3in from body, body 1in from top
\setlength{\textheight}{9.0truein} % 9in high typing area
\setlength{\footskip}{0.5truein}   % footer 0.5in from body, 0.5in from bottom


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Added commands and environments for front matter
%%

\newcommand{\degree}[2]{\gdef\@degree{#1} \gdef\@degreeabbrv{#2}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}}
%
% Bachelor's degrees
\newif\ifbachelorsone
\bachelorsonefalse
\def\bachelors#1#2{\gdef\@bachelors{#1, \MakeTextUppercase{#2}}\bachelorsonetrue}
\newif\ifbachelorstwo
\bachelorstwofalse
\def\secondbachelors#1#2{\gdef\@secondbachelors{#1, \MakeTextUppercase{#2}}\bachelorstwotrue}
\newif\ifbachelorsthree
\bachelorsthreefalse
\def\thirdbachelors#1#2{\gdef\@thirdbachelors{#1, \MakeTextUppercase{#2}}\bachelorsthreetrue}
%
% Master's degrees
\newif\ifmastersone
\mastersonefalse
\def\masters#1#2{\gdef\@masters{#1, \MakeTextUppercase{#2}}\mastersonetrue}
\newif\ifmasterstwo
\masterstwofalse
\def\secondmasters#1#2{\gdef\@secondmasters{#1, \MakeTextUppercase{#2}}\masterstwotrue}
\newif\ifmastersthree
\mastersthreefalse
\def\thirdmasters#1#2{\gdef\@thirdmasters{#1, \MakeTextUppercase{#2}}\mastersthreetrue}
%
% Doctorates
\newif\ifpriordoctorate
\priordoctoratefalse
\def\priordoctorate#1#2{\gdef\@priordoctorate{#1, \MakeTextUppercase{#2}}\priordoctoratetrue}
%
% Chair(s)
\newif\ifcochairs
\cochairsfalse
\def\committeechair#1{\gdef\@committeechair{#1}\cochairsfalse}
\def\cochairs#1#2{\gdef\@firstchair{#1}\gdef\@secondchair{#2}\cochairstrue}
\def\firstreader#1{\gdef\@firstreader{#1}}
\newif\ifsecond
\secondfalse
\def\secondreader#1{\gdef\@secondreader{#1}\secondtrue}
\newif\ifthird
\thirdfalse
\def\thirdreader#1{\gdef\@thirdreader{#1}\thirdtrue}
\newif\iffourth
\fourthfalse
\def\fourthreader#1{\gdef\@fourthreader{#1}\fourthtrue}
\newif\iffifth
\fifthfalse
\def\fifthreader#1{\gdef\@fifthreader{#1}\fifthtrue}
\newif\ifsixth
\sixthfalse
\def\sixthreader#1{\gdef\@sixthreader{#1}\sixthtrue}
% To change Department Chair to Chair, call like this:
% \departmentchair[Chair]{Jane Doe}.
\newcommand{\departmentchair}[2][Chairperson]{
  \gdef\umassthesis@chairtitle{#1}
  \gdef\@departmentchair{#2}
  }
\newcommand{\programdirector}[2][Program Director]{
  \gdef\umassthesis@directortitle{#1}
  \gdef\@programdirector{#2}
  }
\def\departmentname#1{\gdef\@departmentname{#1}}
\def\departmentprogram#1{\gdef\@departmentprogram{#1}}

\ifcondensed@frontmatter
  \input{umthcfm.clo}
\else
  \input{umthstd.clo}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tweak chapter headings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%% Text heading tweaks
%%

\setcounter{secnumdepth}{5}

\ifcondensed@frontmatter
  \setcounter{tocdepth}{0}
\else
  \setcounter{tocdepth}{3}
\fi

\ifdouble@space
\renewcommand{\section}{
  \@startsection{section}{1}{\z@}
                {4.5ex \@plus 1ex \@minus .2ex}
                {0.001ex \@plus .2ex}
                {\normalfont\doublespacelarge\bfseries}}

\renewcommand{\subsection}{
  \@startsection{subsection}{2}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {0.001ex \@plus .2ex}%
                {\normalfont\doublespacenormalsize\bfseries}}

\renewcommand{\subsubsection}{
  \@startsection{subsubsection}{3}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {0.001ex \@plus .2ex}%
                {\normalfont\doublespacenormalsize\bfseries}}

\renewcommand{\paragraph}{
  \@startsection{paragraph}{4}{\z@}%
                {2.5ex \@plus1ex \@minus.2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\subparagraph}{
  \@startsection{subparagraph}{5}{\parindent}%
                {0.0ex \@plus1ex \@minus .2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}
\else\ifnicer@draft\else
\renewcommand{\section}{
  \@startsection{section}{1}{\z@}
                {3.5ex \@plus 1ex \@minus .2ex}
                {2.3ex \@plus .2ex}
                {\normalfont\large\bfseries}}

\renewcommand{\subsection}{
  \@startsection{subsection}{2}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\subsubsection}{
  \@startsection{subsubsection}{3}{\z@}%
                {3.25ex \@plus 1ex \@minus .2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\paragraph}{
  \@startsection{paragraph}{4}{\z@}%
                {3.25ex \@plus1ex \@minus.2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}

\renewcommand{\subparagraph}{
  \@startsection{subparagraph}{5}{\parindent}%
                {3.25ex \@plus1ex \@minus .2ex}%
                {-1em}%
                {\normalfont\normalsize\bfseries}}
\fi\fi
%%
%% Fix captions
%%

\setlength\abovecaptionskip{\topskip}
\setlength\belowcaptionskip{\topskip}

\long\def\@makecaption#1#2{%
  \addvspace{\abovecaptionskip}
  \sbox\@tempboxa{\textbf{#1.} #2}%
  \ifdim \wd\@tempboxa >\hsize
    \textbf{#1.} #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \par
  \vskip\belowcaptionskip
  \par
  }


%%
%% Default spacing of tabular environment to single
%%
\let\base@tabular\tabular
\renewcommand{\tabular}[2][]{\base@tabular[#1]{#2}}

%%
%% Fix quote and quotation environments
%%
\renewenvironment{quotation}{%
  \list{}{%
    \listparindent 1.5em%
    \itemindent    \listparindent%
    \rightmargin   \leftmargin%
    \parsep        \z@ \@plus\p@%
    }%
  \normalsize%
  \item[]%
  }%
{\endlist}
% alias quote to quotation
\renewenvironment{quote}{\begin{quotation}}{\end{quotation}}

%%
%% Fix footnotes -- double spacing between footnotes, single spacing within
%%     footnotes is what is required.

\newlength{\umassthesis@basefootnotesep}
\newlength{\umassthesis@baseskipfootins}

\setlength{\umassthesis@basefootnotesep}{\footnotesep}
\setlength{\umassthesis@baseskipfootins}{\skip\footins}

\ifdouble@space
  \setlength{\footnotesep}{2\umassthesis@basefootnotesep}
  \setlength{\skip\footins}{2\umassthesis@baseskipfootins}
\fi

\pretocmd{\@footnotetext}{\linespread{1}\selectfont}%
  {\typeout{Patching footnotetext succeeded}}%
  {\typeout{Patching footnotetext failed}}

%%
%% Fix the bibliography

\AtBeginDocument{%
  \let\base@thebibliography\thebibliography%
  \let\endbase@thebibliography\endthebibliography%
  %
  \@ifpackageloaded{biblatex}{%
    % Double-space the bibliography entries, according to an interpretation
    % of the discussion at
    % http://tex.stackexchange.com/questions/13742/what-does-double-spacing-mean
    \setlength{\bibitemsep}{\baselineskip}%
    % Add entry to TOC
    \AtBeginBibliography{%
      \addcontentsline{toc}{\toc@section}{\MakeTextUppercase{\bibname}}%
    }%
  }{%
    % Add entry to TOC
    \renewenvironment{thebibliography}[1]{%
      \begin{base@thebibliography}{#1}%
        \addcontentsline{toc}{\toc@section}{\MakeTextUppercase{\bibname}}%
      }{\end{base@thebibliography}}%
  }%
}

\newcommand{\doublespace}{\doublespacenormalsize}

% silence hyperref warning about bookmark level
\providecommand*{\toclevel@FrontMatter}{0}
\providecommand*{\toclevel@Chapter}{0}
