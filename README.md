
TODO: latex introduction guide

**Why**
  - No need for anyone to invent the wheel again. You can of course do that
    if you wish - TeX'll even let you invent many different kinds of wheels
  - That said, if you come up with a great new wheel, we would like to hear about 
    it - it might even end up being used here. Merge requests are welcome!
 
**Features**
  - Proper page sizes as required by university guide for students:
      - proper font sizes as well as linespacings
      - proper size of margins
  - Generic title page:
      - \gentitle
  - Generic abstract page(s):
      - \begin{itabstract}{Keywords}
          abstract text
        \end{itabstract}
      - \begin{ittiivis}...\end{ittiivis} provides finnish version
         - ittiivis defaults to finnish so no need to issue 
           \selectlanguage{finnish}
      - total number of pages as well as total number of pages in appendices
        are automagically handled
  - Entry environment:
      - \begin{entry}[widest label]
          \item[1st label text] ...
          \item[2nd label text] ...
        \end{entry}
      - the actual items are aligned to suit the widest label, which is
        given as an argument to the environment
  - Use of specific latex packages to ease in formatting the thesis:
      - format table of contents to have bibliography shown as references
        as well as other fixes           (tocbibind)
      - enhanced verbatim handling       (sverb)
      - source code inclusion            (listings)
      - handling of headers and footers  (fancyhdr)

      - consultation of the manuals of these packages is strongly
        encouraged 

**Assumptions**
  - itpackage.sty file is available 
  - each chapter is as a separate file which is read in with e.g. \input
   
**Miscellaneous**
  - comments are welcome
  - should a required package be missing see http://www.ctan.org/ 
  - http://www.ctan.org/tex-archive/info/lshort/english/lshort.pdf
