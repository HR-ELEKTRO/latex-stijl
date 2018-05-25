# Define target and source file here:
TARGET       = Handleiding_LaTeX-stijl_HR
SOURCE       = main
DEPENDENCIES = *.tex bibliography.bib
USER         = HarryBroeders
REPOSITORY   = HR_ELEKTRO/latex-stijl/downloads 

# Define font here:
#FONT         = "\timestrue"
FONT         = "\chartertrue"
#FONT         = "\opensanstrue"
# For standard latex fonts use:
#FONT         = 

# Options:
PDFLATEXOPT  = -shell-escape -interaction=batchmode -file-line-error -halt-on-error
BIBEROPT  = --quiet

LATEXBINDIR  = C:/texlive/2017/bin/win32
UTILSBINDIR  = C:/gnuwin32/bin
PDFLATEX     = $(LATEXBINDIR)/pdflatex.exe
BIBER        = $(LATEXBINDIR)/biber.exe
RM           = $(UTILSBINDIR)/rm.exe
MAKE         = $(UTILSBINDIR)/make.exe
MV           = $(UTILSBINDIR)/mv.exe
ECHO         = $(UTILSBINDIR)/echo.exe
GIT          = $(GITBINDIR)/git.exe

.PHONY : all
all : $(TARGET).pdf $(TARGET)_ebook.pdf

.PHONY : clean
clean :
	$(RM) -f '*.aux' $(TARGET).pdf $(TARGET)_ebook.pdf $(SOURCE).log $(SOURCE).toc $(SOURCE).out $(SOURCE).bcf $(SOURCE).blg $(SOURCE).bbl $(SOURCE).run.xml

.PHONY : build
build :
	$(MAKE) clean
	$(MAKE)
	
.PHONY : commit
commit :	
	cmd /C $(GIT) commit -a
	
.PHONY : push
push :
	cmd /C $(GIT) push
	upload-to-bitbucket $(USER) $(REPOSITORY) $(TARGET).pdf $(TARGET)_ebook.pdf 

$(TARGET)_ebook.pdf : $(SOURCE).tex $(DEPENDENCIES)
	$(RM) -f args.tex
	$(ECHO) "\ebooktrue" >args.tex
	$(ECHO) $(FONT) >>args.tex
	$(BIBER) $(BIBEROPT) $(basename $<)
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(BIBER) $(BIBEROPT) $(basename $<) 
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $(SOURCE).pdf $(TARGET)_ebook.pdf

$(TARGET).pdf : $(SOURCE).tex $(DEPENDENCIES)
	$(RM) -f args.tex
	$(ECHO) "\ebookfalse" >args.tex
	$(ECHO) $(FONT) >>args.tex
	$(BIBER) $(BIBEROPT) $(basename $<)
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(BIBER) $(BIBEROPT) $(basename $<)
	$(PDFLATEX) $(PDFLATEXOPT) $<
	$(MV) $(SOURCE).pdf $(TARGET).pdf
