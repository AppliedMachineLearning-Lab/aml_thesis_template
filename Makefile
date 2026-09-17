# Build the thesis. Output lands in build/thesis.pdf.
#
#   make          compile (latexmk reruns pdflatex and biber as needed)
#   make watch    recompile on every save
#   make clean    remove build artefacts, keep the PDF
#   make purge    remove build/ entirely
#   make count    approximate word count of the body chapters

MAIN := thesis

.PHONY: all watch clean purge count

all:
	latexmk -pdf $(MAIN).tex

watch:
	latexmk -pdf -pvc $(MAIN).tex

clean:
	latexmk -c $(MAIN).tex

purge:
	latexmk -C $(MAIN).tex
	rm -rf build

count:
	@texcount -inc -sum -q text/ch*.tex 2>/dev/null
