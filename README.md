# AML Lab Thesis Template

A LaTeX template for bachelor's and master's theses written with the
**Applied Machine Learning Lab** at the University of Bonn.

Every file is a skeleton, and its comments explain what belongs there. Read the comments as you go,
then delete them.

## Who this is for

Students writing a **bachelor's or master's** thesis supervised by the AML Lab. If you are not one
yet and would like to be, the lab's open topics and application process are here:
<https://appliedmachinelearning-lab.github.io/teaching/theses/>

It is **not** intended for doctoral theses, which carry different requirements. Adapting it for one
would be perfectly possible, but that is out of scope here.

Beyond the title page and the colours, nothing is lab-specific, so it works as a general thesis
template too. The house rules below are opinions, not requirements of the examination office: check
your own regulations, which take precedence. Feel free to use it outside the AML Lab and the
University of Bonn.

## Compiling

`thesis.tex` in the repository root is the entry point. Everything else is pulled in from there.

```sh
make            # build -> build/thesis.pdf
make watch      # rebuild on every save
make clean      # remove build artefacts, keep the PDF
make purge      # remove build/ entirely
make count      # approximate word count of the body chapters
```

`make` runs `latexmk`, which reruns pdfLaTeX and biber as often as needed. If you prefer to drive
the build yourself, or your editor does it for you, point it at `thesis.tex` with pdfLaTeX and
biber; do not use bibtex.

## What you need

A TeX distribution (TeX Live, MacTeX, MiKTeX) with **pdfLaTeX**, **latexmk** and **biber**.

A *full* installation already has everything. Minimal and split installations usually do not: the
fonts this template uses are the pieces most often left out.

| CTAN package | Provides | Needed for |
|---|---|---|
| `fira` | `FiraMono.sty` | monospace |
| `newpx` | `newpxtext.sty`, `newpxmath.sty` | Palatino text and matching maths |
| `binhex` | `binhex.tex` | `newpxmath` inputs it unconditionally |
| `tex-gyre` | `tgheros.sty`, Pagella | Helvetica sans, Palatino |

A missing `.sty` stops the build outright, but a missing *font* does not: LaTeX substitutes another
and carries on, so treat `LaTeX Font Warning: Font shape ... undefined` in the log as a failure
rather than noise.

## First steps

1. Fill in the fields at the top of `text/titlepage.tex`.
2. Name your `.bib` file in `preamble.tex`, and put your notation macros there.
3. Work through `text/` in order. Delete the placeholder prose as you replace it.
4. Trim or delete `text/notations.tex` and `text/abbreviations.tex`; both ship with example content.
5. Switch `\documentclass[regular]` to `\documentclass[print]` in `thesis.tex` when you send it to
   be bound. At the time of writing, bachelor's and master's theses at the Institute of Computer
   Science at the University of Bonn do *not* have to be printed and are handed in as a digital
   file upload. Check with the examination office rather than relying on this note.

## Layout

```
thesis.tex                 entry point: class option and \input order
aml-thesis.cls             the house style -- you should not need to edit this
preamble.tex               your bib file, extra packages, your own macros
text/                      all prose (titlepage, abstract, ch1-ch5, appendix, ...)
figures/template/          logos
figures/examples/          worked example diagrams (delete as you replace them)
tables/                    table fragments (.tex)
bibliography/references.bib
examples/compiled.pdf      what this template produces, unedited
```

Three levels, and it is worth knowing which is which:

- **`aml-thesis.cls`** is the lab's shared style: fonts, colours, headings, how tables and captions
  look, how citations are formatted. Every thesis written here looks the same because of this file.
  Leave it alone.
- **`preamble.tex`** is yours. Extra packages, your notation macros, and any deliberate override of
  a class default.
- **`text/`** is prose only. A `\usepackage` or `\newcommand` in a chapter belongs in the preamble.

## Class options

```latex
\documentclass[regular]{aml-thesis}   % uniform margins, no blank pages
\documentclass[print]{aml-thesis}     % alternating margins, blank versos
```

Switching is one token; nothing else needs editing. Other options (`DIV=11`, `a5paper`, …) pass
straight through to KOMA's `scrreprt`.

## House rules

| Rule | Why |
|---|---|
| Labels prefixed `sec:` `fig:` `tab:` `eq:` | You can tell what a `\ref` will return |
| `\Cref{...}`, never bare `\ref` | cleveref supplies the word and keeps it correct when floats move |
| `\textcite` / `\parencite`, never `\cite` | plain `\cite` is ambiguous under authoryear |
| booktabs rules, no vertical rules | a table needing vertical rules needs fewer columns |
| Bold headers and row labels, striped rows, `\texttt` figures | see `tables/example_table.tex` |
| `\bm` for bold maths, not `\mathbf` | `\mathbf` fails silently on Greek letters |
| Colour only from a colour-blind-safe palette | see the colour section of chapter 2 |

Fuller explanations live in the comments of the file each rule applies to.

## Where this came from

This template began as the LaTeX source of [*Cryptocurrencies: Trading and Return Prediction via
Machine Learning Methods*](https://research.cbs.dk/en/studentProjects/cryptocurrencies-trading-and-return-prediction-via-machine-learni/),
a 2018 master's thesis by Tobias Deußer (now a postdoc at the lab) and Lars Hillebrand (now a
postdoc at Fraunhofer IAIS), written at Copenhagen Business School. The full text is available from
the CBS Research Portal at the link above.

It has since been rewritten to fit the needs of the AML Lab at the University of Bonn. The rewrite
was carried out with the help of Claude Opus 5.
