# Makefile for MSYS2 under Windows or Linux
# BroJZ MuiKo aug 2023

# Define target and source file here:
TARGET := Tabel2020
SOURCE := main
DEPENDENCIES := *.tex

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
all : $(TARGET).pdf $(TARGET)_ebook.pdf

.PHONY : clean
clean :
	-$(RM) -f *.aux $(SOURCE).log $(SOURCE).toc $(SOURCE).out $(SOURCE).bcf $(SOURCE).blg $(SOURCE).bbl $(SOURCE).run.xml $(SOURCE).synctex.gz $(SOURCE).fdb_latexmk $(SOURCE).fls *.bak

.PHONY : cleanall
cleanall :
	-$(RM) -f $(TARGET).pdf $(TARGET)_ebook.pdf 
	$(MAKE) clean

.PHONY : build
build :
	$(MAKE) cleanall
	$(MAKE)

$(TARGET)_ebook.pdf : $(SOURCE).tex $(DEPENDENCIES)
	$(RM) -f args.tex
	$(ECHO) -n \\ >args.tex
	$(ECHO) "ebooktrue" >>args.tex
	$(ECHO) $(FONT) >>args.tex
	-$(PDFLATEX) $(PDFLATEXOPT) $<
	$(BIBER) $(BIBEROPT) $(basename $<) 
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $(SOURCE).pdf $(TARGET)_ebook.pdf

$(TARGET).pdf : $(SOURCE).tex $(DEPENDENCIES)
	$(RM) -f args.tex
	$(ECHO) -n \\ >args.tex
	$(ECHO) "ebookfalse" >>args.tex
	$(ECHO) $(FONT) >>args.tex
	-$(PDFLATEX) $(PDFLATEXOPT) $<
	$(BIBER) $(BIBEROPT) $(basename $<)
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $(SOURCE).pdf $(TARGET).pdf
