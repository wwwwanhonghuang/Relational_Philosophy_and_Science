# Compiler and flags
LATEX = pdflatex
BIBTEX = bibtex
LATEX_FLAGS = -interaction=nonstopmode -file-line-error

# Source files
TEX_SRC_FILE = book.tex
BIB_FILE = references.bib
PDF_FILE = $(TEX_SRC_FILE:.tex=.pdf)

# Default target
all: $(PDF_FILE)

# Main rule to create PDF
$(PDF_FILE): $(TEX_SRC_FILE) $(BIB_FILE)
	@echo "First LaTeX pass..."
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE)
	@echo "Running BibTeX..."
	$(BIBTEX) $(TEX_SRC_FILE:.tex=)
	@echo "Second LaTeX pass..."
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE)
	@echo "Third LaTeX pass..."
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE)
	@echo "PDF created: $(PDF_FILE)"

# Clean up generated files
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot $(PDF_FILE)

# Clean everything including PDF
distclean: clean
	rm -f $(PDF_FILE)

# Phony targets
.PHONY: all clean distclean