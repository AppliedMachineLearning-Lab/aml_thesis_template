# latexmk configuration.
#   $pdf_mode = 1  -> build with pdflatex (this template targets pdflatex;
#                     switching to lualatex means revisiting inputenc/fontenc).
#   biber is selected automatically from the .bcf that biblatex writes.
$pdf_mode = 1;
# Never stop for keyboard input. Without this a missing \input file makes
# pdflatex sit at a "Please type another input file name:" prompt forever
# instead of failing.
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error %O %S';
$bibtex_use = 2;
$clean_ext = 'bbl run.xml synctex.gz nav snm vrb';
$out_dir = 'build';
