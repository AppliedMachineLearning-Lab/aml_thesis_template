% =============================================================================
%  aml-thesis.cls -- document class for lab theses.
%
%  This file is the house style: typography, colours, headings, captions, table
%  and figure conventions, bibliography style. It is shared by every thesis
%  written with this template and should change rarely and deliberately.
%
%  Per-thesis settings -- your bibliography file, extra packages, your own
%  notation macros -- belong in preamble.tex, NOT here. If you find
%  yourself editing this file to write your thesis, you are in the wrong place.
%
%  Built on KOMA-Script's scrreprt. Targets pdflatex.
% =============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{aml-thesis}[2026/09/17 v1.0 Lab thesis class]

% ---- Class options ----------------------------------------------------------
%   regular  (default)  screen/submission layout: uniform margins, no blank
%                       filler pages.
%   print               print layout: alternating margins for binding, blank
%                       versos before chapters.
%
% Any other option is handed straight to scrreprt, so \documentclass[print,
% DIV=11]{aml-thesis} works as you would expect.
\newif\if@aml@print \@aml@printfalse
\DeclareOption{regular}{\@aml@printfalse}
\DeclareOption{print}{\@aml@printtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}
\ProcessOptions\relax

\if@aml@print
  \PassOptionsToClass{twoside}{scrreprt}
\else
  \PassOptionsToClass{oneside}{scrreprt}
\fi

% DIV drives the KOMA type area: larger DIV = wider text block. Override it as
% a class option rather than loading `geometry' and fighting KOMA.
\LoadClass[a4paper,12pt,openany,DIV=9,numbers=noendperiod,chapterprefix=true]{scrreprt}

% ---- Language and encoding --------------------------------------------------
% Required because this class targets pdflatex. babel controls hyphenation,
% "Figure"/"Table" captions and date formats; to change language, override
% babel in preamble.tex rather than editing this line.
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage[british]{babel}

% ---- Fonts ------------------------------------------------------------------
% Serif / body: Palatino, via newpxtext (TeX Gyre Pagella), paired with its
%   matched maths font newpxmath in the maths block below, so text and
%   equations are one design rather than two near-identical Palatinos.
%   newpxmath does \input{binhex} and therefore needs texlive-plaingeneric
%   installed alongside texlive-fontsextra.
% Sans: Helvetica, via TeX Gyre Heros -- set up by newpxtext itself, which is
%   why tgheros is NOT loaded separately. Doing both is a hard error: each
%   defines \qhv@scale. `helvratio' is newpxtext's own scale for it (0.94 by
%   default), since Helvetica's x-height runs large beside Palatino.
% Mono: Fira Mono, lining figures. `nott' stops newpxtext claiming typewriter
%   for its own npxtt, leaving it to FiraMono.
\RequirePackage[helvratio=0.90,nott]{newpxtext}
\RequirePackage[lining,scale=0.85]{FiraMono}

% ---- Spacing ----------------------------------------------------------------
\RequirePackage{setspace}
\linespread{1.25}

% ---- Colour palette ---------------------------------------------------------
% Data colours first, because the document accents are drawn from them. These
% are Paul Tol's `vibrant' qualitative scheme: colour-blind safe and sound in
% greyscale print. Any colour in a figure should come from this list,
% decorative or not, and a thesis is free to swap the scheme for another that
% is equally safe. Take them from the top rather than picking favourites --
% the order is designed so the first N remain separable.
\RequirePackage[table]{xcolor}
\definecolor{tolorange}{HTML}{EE7733}
\definecolor{tolblue}{HTML}{0077BB}
\definecolor{tolcyan}{HTML}{33BBEE}
\definecolor{tolmagenta}{HTML}{EE3377}
\definecolor{tolred}{HTML}{CC3311}
\definecolor{tolteal}{HTML}{009988}
\definecolor{tolgrey}{HTML}{BBBBBB}

% Document accents, taken from the same scheme so the furniture and the figures
% agree. `accent' drives links and listing keywords; `highlight' is spare, for
% anything that needs a second, contrasting mark.
%
% Headings, caption labels and table rules are deliberately NOT accented: bold
% and weight distinguish them, and black holds up better than colour over a
% long document. The *soft variants are tints, so diagram fills stay in step if
% the accents are ever re-pointed. Redefining these in preamble.tex rebrands
% the document; nothing else in the class hard-codes a colour.
\colorlet{accent}{tolblue}
\colorlet{highlight}{tolorange}
\colorlet{accentsoft}{accent!12}
\colorlet{highlightsoft}{highlight!15}

% ---- Hyperlinks -------------------------------------------------------------
% Loaded before the heading styling so KOMA and hyperref agree on anchors, and
% after the palette so the colours below are already defined.
%
% Internal links stay black so the printed version is not a rainbow; external
% links and citations take the accent, which a reader has to pick out of
% running text.
\RequirePackage{hyperref}
\hypersetup{
  colorlinks = true,
  urlcolor   = accent,
  citecolor  = accent,
  linkcolor  = black,
  pdfborder  = {0 0 0},
}

% ---- Headings ---------------------------------------------------------------
% Headings stay black: KOMA already sets them sans-serif and bold, which is
% distinction enough, and black holds up better than an accent over a long
% document. The accent is spent on links and listing keywords instead.
\addtokomafont{disposition}{\color{black}}
\addtokomafont{chapterprefix}{\Large}
\renewcommand{\raggedchapter}{\centering}
\RequirePackage[automark,autooneside=false]{scrlayer-scrpage}

% ---- Maths ------------------------------------------------------------------
% newpxmath is the Palatino-matched maths font. It must come after amsmath and
% after newpxtext, and it supplies the AMS symbols itself -- so amssymb is
% deliberately NOT loaded here; loading both clashes over symbol definitions.
% \bm goes last, after the maths font is settled.
%
% Also deliberately NOT loaded: bbm and dsfont. \mathbb covers the same ground,
% and \bm is the correct way to bold maths (\mathbf fails silently on Greek).
\RequirePackage{amsmath,amsthm,mathtools}
\RequirePackage{newpxmath}
\RequirePackage{bm}

% Theorem-like environments, numbered per chapter so references stay readable.
% Add your own in preamble.tex with \newtheorem.
\theoremstyle{definition}
\newtheorem{definition}{Definition}[chapter]
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{proposition}{Proposition}[chapter]
\newtheorem{lemma}{Lemma}[chapter]

% ---- Algorithms -------------------------------------------------------------
% algorithm supplies the float; algorithmic supplies the pseudo-code body, in
% the classic uppercase dialect (\STATE, \FOR ... \TO, \IF ... \ENDIF).
%
% Loaded BEFORE cleveref so that \Cref knows what an algorithm is; cleveref
% only learns about float types that already exist when it loads.
%
% algorithm2e and algpseudocode are the other common choices and are installed,
% but they use a different, incompatible dialect. Pick one and hold to it: two
% pseudo-code styles in one thesis look like an accident.
\RequirePackage{algorithm}
\RequirePackage{algorithmic}

% ---- Code listings ----------------------------------------------------------
% For pseudo-code prefer algorithm2e/algpseudocode; listings is for real source.
\RequirePackage{listings}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codebg}{rgb}{0.97,0.97,0.97}
\lstdefinestyle{thesis}{
  backgroundcolor = \color{codebg},
  basicstyle      = \footnotesize\ttfamily,
  keywordstyle    = \color{accent}\bfseries,
  commentstyle    = \color{codegray}\itshape,
  numberstyle     = \tiny\color{codegray},
  numbers         = left,
  numbersep       = 8pt,
  breaklines      = true,
  captionpos      = b,
  frame           = none,
  showstringspaces= false,
  tabsize         = 2,
}
\lstset{style=thesis}

% ---- Cross-references -------------------------------------------------------
% cleveref is load-order sensitive: it must come AFTER both hyperref and
% amsmath, which is why it sits here rather than up with the other packages.
% It supplies the word as well as the number: \cref{sec:foo} -> "section 2",
% \Cref{sec:foo} -> "Section 2", \cref{fig:a,fig:b} -> "figures 1 and 2".
\RequirePackage[capitalise,noabbrev]{cleveref}
\crefname{equation}{equation}{equations}
\crefname{algorithm}{algorithm}{algorithms}
\Crefname{algorithm}{Algorithm}{Algorithms}

% ---- Utilities --------------------------------------------------------------
% etoolbox gives \ifblank, used by the title page to drop an optional line when
% its field is left empty. biblatex pulls it in anyway; load it explicitly so
% the dependency is not accidental.
\RequirePackage{etoolbox}

% ---- Lists ------------------------------------------------------------------
\RequirePackage{enumitem}

% ---- Tables -----------------------------------------------------------------
% booktabs = horizontal rules only (\toprule/\midrule/\bottomrule).
% siunitx  = decimal-aligned numeric columns via the S column type. The house
%            style sets figures in \texttt instead (see tables/example_table.tex);
%            siunitx stays available for tables that need true decimal alignment.
% Deliberately NOT loaded: tabu (unmaintained and broken against current LaTeX
% kernels), tabularx, ltablex, cellspace. Use longtable for tables that must
% break across pages.
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{siunitx}
% round-integer-to-decimal was removed in siunitx v3. It was inert here in any
% case: it only ever applied when round-mode was switched on, which this
% template does not do. v3's equivalent is round-pad, on by default.
\sisetup{
  table-number-alignment    = center,
  detect-all,
  table-align-text-pre      = false,
  table-align-text-post     = false,
  input-signs               = + -,
}
% Rules stay black: the table's structure is not a place for colour.
\arrayrulecolor{black}
\renewcommand{\arraystretch}{1.3}

% ---- Figures ----------------------------------------------------------------
% subcaption (not the obsolete subfig) for sub-figures: \begin{subfigure}.
\RequirePackage{tikz}
\usetikzlibrary{positioning,arrows,arrows.meta,calc,chains,quotes,shapes,shapes.multipart,fit,
                decorations.markings,decorations.text,decorations.pathreplacing,ext.paths.ortho}
\RequirePackage{graphicx}
\RequirePackage{adjustbox}
\RequirePackage{caption}
\RequirePackage{subcaption}
% format=plain makes continuation lines start at the left margin like ordinary
% text. Without it KOMA's hanging style indents them under the caption text,
% aligned past the "Table 4.1:" label.
\captionsetup{
  format    = plain,
  font      = footnotesize,
  labelfont = bf,
}

% ---- Epigraphs (optional chapter-opening quotes) ----------------------------
\RequirePackage{epigraph}
\setlength\epigraphwidth{.7\textwidth}
\setlength\epigraphrule{0pt}
\renewcommand{\textflush}{flushepinormal}
\renewcommand{\epigraphflush}{center}

% ---- Appendix ---------------------------------------------------------------
\RequirePackage[title]{appendix}

% ---- Quotations -------------------------------------------------------------
% csquotes must be loaded BEFORE biblatex, which warns if it is missing while
% babel is in use. It supplies \enquote{...}, which produces the right quote
% marks for the current babel language -- use it instead of typing `` and ''
% by hand, and quoted material stays correct if the language ever changes.
\RequirePackage{csquotes}

% ---- Bibliography style -----------------------------------------------------
% biber + authoryear. Cite with \textcite (authors are the sentence's subject)
% or \parencite (parenthetical). Do not use plain \cite: it is ambiguous under
% authoryear and produces inconsistent output.
%
% The .bib file itself is named in preamble.tex with \addbibresource --
% that is a property of your thesis, not of the house style.
\RequirePackage[
  backend      = biber,
  style        = authoryear,
  maxcitenames = 2,
  maxbibnames  = 10,
  minbibnames  = 10,
  sorting      = nyt,
  giveninits   = false,
  uniquename   = full,
  doi          = false,
  isbn         = false,
  url          = true,   % only entries that deliberately keep a url have one
]{biblatex}
% Printed entries give names in reading order and in full: "Tobias Deusser",
% not "Deusser, T." -- hence given-family here and giveninits=false above.
% In-text citations are unaffected: they stay (Family Year), which is what
% authoryear is for.
%
% maxbibnames/minbibnames at 10 means an author list longer than ten is cut
% after the tenth and closed with "et al." Setting both to the same value is
% what makes it cut AT ten; minbibnames alone decides how many survive.
\DeclareNameAlias{sortname}{given-family}

% Number the printed entries. The authoryear style has no numbers of its own --
% citations in the text read (Author Year) -- but a numbered list is markedly
% easier to scan and to refer to in conversation. These numbers are NOT citation
% labels: nothing in the text points at them, and they renumber freely as
% entries are added.
\defbibenvironment{bibliography}
  {\begin{enumerate}[label=\arabic*.,
                     leftmargin=*,
                     labelsep=1ex,
                     topsep=0pt,
                     itemsep=\bibitemsep,
                     parsep=\bibparsep]}
  {\end{enumerate}}
  {\item}

% ---- Reference lists --------------------------------------------------------
% mclistof: an unnumbered chapter holding a two-column list of terms, used for
% the List of Notations and the List of Abbreviations.
%
%   \begin{mclistof}{List of Abbreviations}{3.2cm}
%     \item[NER] Named entity recognition
%   \end{mclistof}
%
% #1 is the heading, which is also added to the table of contents.
% #2 is the width reserved for the bold terms; widen it if a term collides with
% its description, narrow it if the gap looks excessive.
\newenvironment{mclistof}[2]{%
  \chapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}%
  \begin{list}{}{%
    \setlength{\labelwidth}{#2}%
    \setlength{\leftmargin}{\labelwidth}%
    \addtolength{\leftmargin}{\labelsep}%
    \setlength{\itemsep}{0.25em}%
    \setlength{\parsep}{0pt}%
    \setlength{\topsep}{0.5em}%
    \renewcommand{\makelabel}[1]{\textbf{##1}\hfil}%
  }%
}{%
  \end{list}%
}

% ---- Class macros -----------------------------------------------------------
% A blank verso that does not consume a page number.
%
% Only meaningful under `print', where it pushes the following content onto a
% recto. Under `regular' it degrades to a plain \clearpage, so the call sites
% in text/ need no edits when the layout option is switched.
\newcommand{\blankpage}{%
  \clearpage%
  \if@aml@print%
    \thispagestyle{empty}%
    \addtocounter{page}{-1}%
    \null%
    \clearpage%
  \fi}

\endinput
