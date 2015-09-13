# Define target and source file here:
TARGET       = Handleiding_LaTeX-stijl_HR
SOURCE       = main
DEPENDENCIES = titlepage.tex chap01.tex chap02.tex chap03.tex chap04.tex chap05.tex app01.tex bibliography.bib style_nl_NL.tex styleCode.tex 

# Define font here:
#FONT         = \timestrue
FONT         = \chartertrue
# For standard latex fonts use:
#FONT         = 

# Options:
PDFLATEXOPT  = -shell-escape -interaction=nonstopmode -file-line-error

LATEXBINDIR  = C:\texlive\2014\bin\win32
UTILSBINDIR  = C:\WinAVR-20100110\utils\bin
PDFLATEX     = $(LATEXBINDIR)\pdflatex.exe
BIBER        = $(LATEXBINDIR)\biber.exe
RM           = $(UTILSBINDIR)\rm.exe
MAKE         = $(UTILSBINDIR)\make.exe
MV           = $(UTILSBINDIR)\mv.exe

.PHONY : all
all : $(TARGET).pdf $(TARGET)_ebook.pdf

.PHONY : clean
clean :
	$(RM) -f '*.aux' $(TARGET).pdf $(TARGET)_ebook.pdf $(SOURCE).log $(SOURCE).toc $(SOURCE).out $(SOURCE).bcf $(SOURCE).blg $(SOURCE).bbl $(SOURCE).run.xml

.PHONY : build
build :
	$(MAKE) clean
	$(MAKE)

$(TARGET)_ebook.pdf : $(SOURCE).tex $(DEPENDENCIES)
	$(RM) -f args.tex
	echo '\ebooktrue' >args.tex
	echo '$(FONT)' >>args.tex
	$(PDFLATEX) $(SOURCE).tex
	$(BIBER) $(SOURCE)
	$(PDFLATEX) $(SOURCE).tex
	$(MV) $(SOURCE).pdf $(TARGET)_ebook.pdf

$(TARGET).pdf : $(SOURCE).tex $(DEPENDENCIES)
	$(RM) -f args.tex
	echo '\ebookfalse' >args.tex
	echo '$(FONT)' >>args.tex
	$(PDFLATEX) $(SOURCE).tex
	$(BIBER) $(SOURCE)
	$(PDFLATEX) $(SOURCE).tex
	$(MV) $(SOURCE).pdf $(TARGET).pdf
