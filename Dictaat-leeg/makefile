# Define target and source file here:
TARGET       = Voorbeelddictaat
SOURCE       = main
DEPENDENCIES = *.tex bibliography.bib

# Define font here:
#FONT         = "\timestrue"
FONT         = "\chartertrue"
#FONT         = "\opensanstrue"
# For standard latex fonts use:
#FONT         = 

# Options:
PDFLATEXOPT  = -shell-escape -interaction=batchmode -file-line-error
BIBEROPT  = --quiet

LATEXBINDIR  = C:/texlive/2020/bin/win32
UTILSBINDIR  = C:/gnuwin32/bin
PDFLATEX     = $(LATEXBINDIR)/pdflatex.exe
BIBER        = $(LATEXBINDIR)/biber.exe
RM           = $(UTILSBINDIR)/rm.exe
MAKE         = $(UTILSBINDIR)/make.exe
MV           = $(UTILSBINDIR)/mv.exe
ECHO         = $(UTILSBINDIR)/echo.exe

.PHONY : all
all : $(TARGET).pdf $(TARGET)_ebook.pdf

.PHONY : clean
clean :
	-$(RM) -f '*.aux' $(SOURCE).log $(SOURCE).toc $(SOURCE).out $(SOURCE).bcf $(SOURCE).blg $(SOURCE).bbl $(SOURCE).run.xml

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
	$(ECHO) "\ebooktrue" >args.tex
	$(ECHO) $(FONT) >>args.tex
	-$(PDFLATEX) $(PDFLATEXOPT) $<
	$(BIBER) $(BIBEROPT) $(basename $<) 
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $(SOURCE).pdf $(TARGET)_ebook.pdf

$(TARGET).pdf : $(SOURCE).tex $(DEPENDENCIES)
	$(RM) -f args.tex
	$(ECHO) "\ebookfalse" >args.tex
	$(ECHO) $(FONT) >>args.tex
	-$(PDFLATEX) $(PDFLATEXOPT) $<
	$(BIBER) $(BIBEROPT) $(basename $<)
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $(SOURCE).pdf $(TARGET).pdf
