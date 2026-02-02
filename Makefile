LATEX   = pdflatex
BIBTEX  = bibtex

BUILD_PATH := build
TEX_SRC_FILE = book.tex
BIB_NAME = book

LATEX_FLAGS = -interaction=nonstopmode -file-line-error \
              -output-directory=$(BUILD_PATH)

PDF_FILE = $(BUILD_PATH)/$(BIB_NAME).pdf

all: $(PDF_FILE)

$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

$(PDF_FILE): $(TEX_SRC_FILE) | $(BUILD_PATH)
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE)
	$(BIBTEX) $(BUILD_PATH)/$(BIB_NAME)
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE)
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE)

clean:
	rm -rf $(BUILD_PATH)

.PHONY: all clean
