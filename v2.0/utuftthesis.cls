% version 2.0 2018/08/29 new version using document classes, xelatex, biblatex, and some additional TeX scripting by Jari-Matti Mäkelä (jmjm@iki.fi), based on v1.3 by Sami Nuuttila (samnuutt@utu.fi), Johannes Holvitie (jjholv@utu.fi) et al.
% version 1.3+ 1.10.2017//10/1 - 2016/9/22 additions marked "JH:", modified for use in tex.soft.utu.fi, Johannes Holvitie (jjholv@utu.fi)
% version 1.3 2015/9/5 Sami Nuuttila (samnuutt@utu.fi)

% ------------------------------
% How to use? Store the file in
% 1) Windows XP C:\Documents and Settings\<user name>\texmf\tex\latex\local\
% 2) Windows Vista/7 C:\Users\<user name>\texmf\tex\latex\local\
% 3) Linux ~/texmf/tex/latex/local/
% 4) Mac OS X /Users/<user name>/Library/texmf/tex/latex/local/
% 5) Sharelatex: just copy this to the project folder
% 6) or in the same directory as the document
% ------------------------------

\NeedsTeXFormat{LaTeX2e}[2007/01/01]
\ProvidesClass{utuftthesis}[2018/08/29 UTU FT dept BSc/MSc thesis]

\RequirePackage{kvoptions}

\newcommand{\n@tivelang}{finnish}

%% Custom package options
%\DeclareStringOption[00]{year}
\DeclareStringOption[draft]{version}
\DeclareStringOption[a4paper]{paper}
\DeclareStringOption[finnish]{language}
\DeclareStringOption[false]{hidechapters}
\DeclareStringOption[false]{includereferences}

%% Process given options
\ProcessKeyvalOptions*

%% Fallback
%\DeclareOption*{}
%  \ClassWarning{myclass}{Unknown option '\CurrentOption'}
%\ProcessOptions\relax

%% Load base
\LoadClass[\utuftthesis@paper,12pt]{report}

\RequirePackage{ifthen}

%% Some language macros for choosing between content
\newcommand{\langchoose}[3]{\ifthenelse{\equal{#1}{\n@tivelang}}{#2}{#3}}
\newcommand{\langfin}[2]{\ifthenelse{\equal{\utuftthesis@language}{\n@tivelang}}{#1}{#2}}
\newif\iffin
\langfin{\fintrue}{\finfalse}

\RequirePackage{ifxetex}

%% Set up encoding/font/hyphenation stuff
\ifxetex
  \RequirePackage{fontspec}
  \RequirePackage{polyglossia}
  \setmainlanguage{\utuftthesis@language}
\else
% JH: modified latin to UTF-8 encoding cues to make Scandinavian characters works
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
% load babel-package for automatic hyphenation
  \iffin
  \RequirePackage[english, \utuftthesis@language]{babel}
  \else
  \RequirePackage[\utuftthesis@language]{babel}
  \fi
  \RequirePackage{lmodern}
\fi

\RequirePackage{csquotes}

%% Macro for hiding the chapter texts
\ifthenelse{\equal{\utuftthesis@hidechapters}{true}}{
  \renewcommand{\@chapapp}{\relax}
  \renewcommand{\@makechapterhead}[1]{%
    \vspace*{50\p@}%
    {\parindent \z@ \raggedright \normalfont
      \ifnum \c@secnumdepth >\m@ne
          \huge\bfseries \@chapapp\space \thechapter\space\space
      \fi
      \interlinepenalty\@M
      \Huge \bfseries #1\par\nobreak
      \vskip 40\p@
    }}
}
{}

%% load ams-packages for maths
\RequirePackage{amssymb,amsthm,amsmath}

%% load graphicx package
%   - automagically select proper parameters depending on whether
%     we're running pdflatex or latex
%   - specify \includegraphics{file} without the file extension
%     (.eps /.pdf (/ .png / .jpeg / ...)), tex should select the proper file
%
\RequirePackage{ifpdf}
\RequirePackage{graphicx}

%% JM: this note refers to some pre-historic latex distributions, probably
%% safe to disregard
%% 
%% !!! NOTE: if you have ancient LaTeX distribution then you might need to
%% use the following instead
%% \newif\ifpdf
%% \ifx\pdfoutput\undefined
%%   \pdffalse
%% \else
%%   \pdfoutput=1
%%   \pdftrue
%% \fi
%% % if graphicx complains about option clash remove the [pdftex] option
%% \ifpdf
%%   \RequirePackage[pdftex]{graphicx}
%% \else
%%   \RequirePackage[dvips]{graphicx}
%% \fi

\RequirePackage[style=ieee]{biblatex}

%% Define new title texts for the bibliography
\langfin
{\newcommand{\refs}{Lähdeluettelo}}
{\newcommand{\refs}{References}}

%% Modify the \printbibliography command
\defbibheading{bibliography}{
%\eofpages
% label here if we don't include references
\ifthenelse{\equal{\utuftthesis@includereferences}{true}}{}{\label{endofpages}}
\chapter*{\refs}
\addcontentsline{toc}{chapter}{\refs}}

\let\oldprintbibliography\printbibliography
\renewcommand{\printbibliography}{
\oldprintbibliography
% label here if we also include references
\ifthenelse{\equal{\utuftthesis@includereferences}{true}}{\label{endofpages}}{}
}

%% load sverb package
%   - enhanced handling of verbatim stuff; listing environment
\RequirePackage{sverb}

%% load listings package
%   - handle inclusion of source code
\RequirePackage{listings}

%% load fancyheaders package
%   - the actual headers and footers are set later
\RequirePackage{fancyhdr}

%% these are used as global variables on the magic pages
%% feel free to modify if/when the department changes again
\newcommand{\ye@r}{\the\year}
\newcommand{\m@nth}{\the\month}
\newcommand{\s@pervisors}{}
\newcommand{\version}{\utuftthesis@version}
\newcommand\keywords[1]{\def\k@ywords{#1}}
\newcommand\keywordstwo[1]{\def\k@ywordstwo{#1}}
\newcommand\pubyear[1]{\renewcommand\ye@r{#1}}
\newcommand\pubmonth[1]{\renewcommand\m@nth{#1}}
\newcommand\publab[2]{\newcommand\p@blab{#1}\newcommand\p@blaben{#2}}
\newcommand\pubtype[1]{\newcommand\p@btype{#1}}
\newcommand\supervisors[1]{\renewcommand\s@pervisors{#1}}
\newcommand{\laitos}{Tulevaisuuden teknologioiden laitos}
\newcommand{\yliopisto}{Turun yliopisto}
\newcommand{\department}{Department of Future Technologies}
\newcommand{\university}{University of Turku}

% switch-case used to select the thesis type
\newboolean{default}
\newcommand{\case}{}
\newcommand{\default}{}
\newenvironment{switch}[1]{%
    \setboolean{default}{true}
    \renewcommand{\case}[2]{\ifthenelse{\equal{#1}{##1}}{%
        \setboolean{default}{false}##2}{}}%
    \renewcommand{\default}[1]{\ifthenelse{\boolean{default}}{##1}{}}
}{}

%% magic thesis types. more can be added
\newcommand*{\thesistype}[1]{ \begin{switch}{\p@btype}
      \case{tkk}{\langchoose{#1}{TkK -tutkielma}{Bachelor's Thesis}}%
      \case{luk}{\langchoose{#1}{LuK -tutkielma}{Bachelor's Thesis}}%
      \case{gradu}{\langchoose{#1}{Pro gradu -tutkielma}{Master of Science Thesis}}%
      \case{di}{\langchoose{#1}{Diplomityö}{Master of Science Thesis}}%
    \default{\p@btype}%
    \end{switch}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% setup document appearance
%

% change default font to times-roman
\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}

% fix page size
%
%  - page width: 
%     1inch             +
%      \hoffset         +
%      \oddsidemargin   +
%      \textwidth       +
%      \marginsep       +
%      \marginparwidth
%
%  - page height: 
%     1inch             +
%      \voffset         +
%      \topmargin       +
%      \headheight      +
%      \headsep         +
%      \textheight      +
%      \footnotesep     +
%      \footheigth 
%
%  - 1 pt == 1/72 inch == 0.35 mm
%
% page width... left margin 4cm, right 2cm
%
\setlength{\hoffset}{0mm}
\setlength{\marginparsep}{0mm}
\setlength{\marginparwidth}{0mm}
\setlength{\textwidth}{\paperwidth}
\addtolength\textwidth{-60 mm}
\setlength{\oddsidemargin}{-1 in}
\addtolength\oddsidemargin{40 mm}
%
% page height... textheight starts at ~4cm from top, 
% i.e. 1 in + 12 pt + 24 pt = 1.5 in 
%
\setlength{\voffset}{0 mm}
\setlength{\topmargin}{0 mm}
\setlength{\headheight}{14.5 pt}
\setlength{\headsep}{24 pt}
\setlength{\textheight}{230mm}
\setlength{\footnotesep}{12 pt}

 
% setup linespacings to suit to the (stupid) requirement of double spacing
%
% - fake 1.5 linespacing
%    \renewcommand{\baselinestretch}{1.241}
%
% - fake 2 linespacing
%
\renewcommand{\baselinestretch}{1.655}

%% this way the user can choose whatever date library for other stuff
\newcommand{\MONTH}[1]{%
  \ifcase#1
  \or January% 1
  \or February% 2
  \or March% 3
  \or April% 4
  \or May% 5
  \or June% 6
  \or July% 7
  \or August% 8
  \or September% 9
  \or October% 10
  \or November% 11
  \or December% 12
  \fi}
\newcommand{\KUUKAUSI}[1]{%
  \ifcase#1
  \or Tammikuu% 1
  \or Helmikuu% 2
  \or Maaliskuu% 3
  \or Huhtikuu% 4
  \or Toukokuu% 5
  \or Kesäkuu% 6
  \or Heinäkuu%7
  \or Elokuu% 8
  \or Syyskuu% 9
  \or Lokakuu% 10
  \or Marraskuu% 11
  \or Joulukuu% 12
  \fi}
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% provide the entry environment
%

\newenvironment{entry}[1]
{\begin{list}{}{%
      \renewcommand{\makelabel}[1]{\textrm{##1:}\hfil}%
      \settowidth{\labelwidth}{\textrm{#1:}}%
      \setlength{\leftmargin}{\labelwidth}%
      \addtolength{\leftmargin}{\labelsep}}}
{\end{list}}


%% appendix title, abstract environments
\langfin{
  \newcommand{\appname}{Liitteet}
  \renewenvironment{abstract}{\@bstracth{finnish}}{\@bstractt{finnish}{\k@ywords}}
}{
  \newcommand{\appname}{Appendices}
  \renewenvironment{abstract}{\@bstracth{english}}{\@bstractt{english}{\k@ywords}}
}

%% used for listing the supervisors
\RequirePackage{pgffor}

%% title page, reuses the standard \maketitle
\renewcommand*{\maketitle}{%
\clearpage 
\thispagestyle{empty}
\vspace*{\stretch{1}}
\vspace{3mm}
\noindent 
\rule{\linewidth}{1 mm}
\renewcommand{\baselinestretch}{1.05}\normalsize
\begin{flushright}
\Huge{\@title}
\end{flushright}
\rule{\linewidth}{1 mm}
\vspace*{\stretch{4}}
\\
\renewcommand{\baselinestretch}{1}\normalsize
 \iffin
 \begin{tabular}{p{80 mm}p{70 mm}}           \\
 & \thesistype{\n@tivelang} \\
 \else
\begin{tabular}{p{78 mm}p{72 mm}}            \\
 & \thesistype{english}                              \\
 \fi
 & \langfin{\yliopisto}{\university}   \\
 & \langfin{\laitos}{\department}      \\
 & \langfin{\p@blab}{\p@blaben}        \\
 & \ye@r                               \\
 & \@author                            \\
\ifthenelse{\equal{\s@pervisors}{}}{
}{
 &                                           \\
 & \langfin{Tarkastajat}{Supervisors}:                              \\ 
 \foreach \x in \s@pervisors {
\begin{tabular}{p{78 mm}p{72 mm}}            
 & \hspace*{4 ex} \x         \\
\end{tabular}
}}
\end{tabular}
\vspace*{\stretch{1}}\\
\begin{minipage}[b]{\textwidth}
\scriptsize \langfin{{\yliopisto}n laatujärjestelmän mukaisesti tämän julkaisun alkuperäisyys on tarkastettu Turnitin OriginalityCheck-järjestelmällä.}{
The originality of this thesis has been checked in
accordance with the \university quality assurance system using
the Turnitin OriginalityCheck service.}
\end{minipage}
\renewcommand{\baselinestretch}{1.655}\normalsize
\clearpage
}

%% used to detect the number of pages
\RequirePackage[page]{totalcount}

%% used to detect the empty \totalpages on the first latex run
\newcommand*{\IsInteger}[3]{%
    \IfStrEq{#1}{ }{%
        %#3% is a blank string
    }{%
        \IfInteger{#1}{#2}{#3}%
    }%
}%

\RequirePackage{xstring}
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define itabstract environment for abstract page
%
\newcommand{\@bstracth}[1]{%
  \selectlanguage{#1}
  \langchoose{#1}{
    \newcommand{\uni}{\yliopisto}
    \newcommand{\dep}{\laitos}
    \newcommand{\@pp}{s.}
    \newcommand{\@app}{liites.}
  }
  {
    \newcommand{\uni}{\university}
    \newcommand{\dep}{\department}
    \newcommand{\@pp}{p.}
    \newcommand{\@app}{app. p.}
  }
  
  \setlength{\headheight}{0 pt}
  \setlength{\headsep}{0 pt}
  \addtolength\topmargin{-0.54 cm}
  \renewcommand{\baselinestretch}{1}\normalsize
  \clearpage
  \thispagestyle{empty}
  \noindent
  \begin{minipage}[\textheight]{\linewidth}
  \MakeUppercase{\uni}\\
  \dep
  \begin{entry}{}
  \item[\textsc{\@author}] \@title
  \end{entry}
\IsInteger{\totalpages}{
\ifnum \totalpages > 0
  \thesistype{#1}, \pageref{endofpages} \@pp, \totalpages\ \@app \\
\else
  \thesistype{#1}, \pageref{endofpages} \@pp \\
\fi
}
{\thesistype{#1}, \langfin{aja LaTeX uudestaan}{please rerun LaTeX} \\
}
  \langchoose{#1}{\p@blab}{\p@blaben}\\
  \langchoose{#1}{\KUUKAUSI{\m@nth}}{\MONTH{\m@nth}} \ye@r \\
  \rule{\linewidth}{1 pt}
  \\
}

\newcommand{\@bstractt}[2]{%
\bigskip
\\
\selectlanguage{#1}
\newcommand{\kwlabel}{\langchoose{#1}{Asiasanat}{Keywords}}
\begin{entry}{}
\item[\kwlabel] #2
\end{entry}
\end{minipage}
\clearpage
\setcounter{page}{0}
\setlength{\headheight}{12 pt}
\setlength{\headsep}{24 pt}
\setlength{\topmargin}{0 mm}
\renewcommand{\baselinestretch}{1.655}\normalsize
}

%% the second abstract environment
\newenvironment{abstracten}{\@bstracth{english}}{\@bstractt{english}{\k@ywordstwo}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% define \figcaption and \tblcaption for use with non-floating figures and 
% tables
%

\makeatletter
  \newcommand\figcaption{\def\@captype{figure}\caption}
  \newcommand\tblcaption{\def\@captype{table}\caption}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define \startpages
%
\newcommand{\startpages}{%
        \clearpage
        \pagenumbering{arabic}
        \setcounter{page}{1}
        \renewcommand{\baselinestretch}{1.655}

        \pagestyle{fancy}
        \renewcommand{\chaptermark}[1]{
          \markboth{
            \MakeUppercase{\chaptername\ \thechapter.\ ##1}}
          {}
        }
        \lhead{\leftmark}

\chead{\ifthenelse{\equal{draft}{\version}}{[draft]}{}}
        \rhead{\thepage}
        \fancyfoot{}
  \setcounter{totalcount@page}{-1000}
}       



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define \appendices
%
\newcommand{\appendices}{%
  \newpage
  \appendix
  \addtocontents{toc}{\protect\contentsline{chapter}{\appname}{}\relax}
  \renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\appendixname\ \thechapter.\ ##1}}{}}
  \lhead{\leftmark}
  \chead{}
  \rhead{\thechapter-\arabic{page}}
  \fancyfoot{}
  \setcounter{page}{0}
  \renewcommand\thepage{\thechapter-\arabic{page}}
  \setcounter{totalcount@page}{-1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% define \appchapter
%
\newcommand{\appchapter}[1]{%
        \addtocounter{totalcount@page}{\value{page}}
        \clearpage
        \setcounter{page}{1}
        \chapter{#1}
}

%% automatically handle the appendix magic
%\AtEndDocument{\addtocounter{totalcount@page}{-2}}
