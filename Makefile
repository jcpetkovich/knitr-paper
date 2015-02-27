
# Jean-Christophe Petkovich's slightly less than terrible KnitR Makefile

DOCNAME = paper
TEXDEPS = $(shell find . ! -name $(DOCNAME).tex -name "*.tex") 
KNITRDEPS = $(shell find . ! -name $(DOCNAME).Rnw -name "*.Rnw") 

all: $(DOCNAME).pdf

$(DOCNAME).pdf: $(DOCNAME).tex $(TEXDEPS)
	latexmk -pdf -pdflatex="pdflatex -synctex=1 -interactive=nonstopmode" -use-make $(DOCNAME).tex

$(DOCNAME).tex: $(DOCNAME).Rnw $(KNITRDEPS)
	Rscript -e "library(knitr); knit('./"$(DOCNAME)".Rnw')"

clean:
	latexmk -c $(DOCNAME).tex
	rm -f $(DOCNAME).tex
	rm -f $(DOCNAME).pdf
	rm -f $(DOCNAME).synctex.gz

view: $(DOCNAME).pdf
	latexmk -pdf -pv $(DOCNAME).tex

.PHONY: $(DOCNAME).pdf all clean
