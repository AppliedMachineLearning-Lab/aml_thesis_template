# figures/template

Assets the template itself owns: logos and any other furniture that is part of
the lab's identity rather than of one thesis.

Currently held here:

| File | Used as | Notes |
|---|---|---|
| `uni_bonn_logo.jpg` | `\logouniversity` | CMYK JPEG, 3884x1501. pdflatex renders it correctly. |
| `aml_lab_tight.png` | `\logolab` | RGBA PNG, 500x500 (square). |

Both are referenced from the `\logouniversity` / `\logolab` definitions at the
top of `text/titlepage.tex`, both at the same `\logoheight` (20mm), set flush
right as a pair: wordmark first, lab mark to its right.

Both files are tightly cropped -- ink reaches the edge of the bounding box in
each -- so there is no whitespace to `trim` away. The empty upper-left quadrant
of the Bonn lockup is part of the logo's design, not padding.

If either is ever reissued as a PDF, prefer it -- vector reproduces better in
print, and the definitions need no change beyond the filename.

Sibling directory `figures/examples/` holds the worked example diagrams used in
the chapters. Those are demonstrations and are meant to be deleted; the files
here are not.
