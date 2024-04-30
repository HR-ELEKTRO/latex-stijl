# Makefile for MSYS2 under Windows or Linux
# BroJZ MuiKo may 2021

# Create target list
SOURCES := llm.tex
TARGETS :=  $(patsubst %.tex,%.pdf,$(SOURCES))
DEPENDENCIES := style_nl_NL.tex bibliography.bib 

# Define font here:
#FONT := "\timestrue"
FONT := "\chartertrue"
#FONT := "\opensanstrue"
# For standard latex fonts use:
#FONT := 

# Options:
PDFLATEXOPT := -shell-escape -interaction=batchmode -file-line-error
BIBEROPT := --quiet

PDFLATEX := pdflatex
BIBER := biber
RM := rm
MAKE := make
MV := mv
ECHO := echo

.PHONY : all
all : $(TARGETS)

.PHONY : targets
targets :
	$(ECHO) $(TARGETS)
	
.PHONY : clean
clean :
	-$(RM) -f *.log *.toc *.out *.bcf *.blg *.bbl *.run.xml *.synctex.gz *.fdb_latexmk *.fls *.bak 

.PHONY : cleanall
cleanall :
	-$(RM) -f $(TARGETS) *.pdf
	$(MAKE) clean

.PHONY : build
build :
	$(MAKE) cleanall
	$(MAKE)

%.pdf : %.tex $(DEPENDENCIES)
	$(RM) -f args.tex
	$(ECHO) -n \\ >args.tex
	$(ECHO) "ebookfalse" >>args.tex
	$(ECHO) $(FONT) >>args.tex
	-$(PDFLATEX) $(PDFLATEXOPT) $<
	$(BIBER) $(BIBEROPT) $(basename $<) 
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $@ $<.pdf
	$(RM) -f args.tex
	$(ECHO) -n \\ >args.tex
	$(ECHO) "ebooktrue" >>args.tex
	$(ECHO) $(FONT) >>args.tex
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $@ $<_ebook.pdf
