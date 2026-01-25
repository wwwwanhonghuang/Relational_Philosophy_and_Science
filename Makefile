LATEX = pdflatex
BIBTEX = bibtex

BUILD_PATH := ./build
SRC_COPY := $(BUILD_PATH)/src

TEX_SRC_FILE = book.tex
BIB_FILE = references.bib

PDF_FILE = $(BUILD_PATH)/book.pdf

LATEX_FLAGS = -interaction=nonstopmode -file-line-error

all: $(PDF_FILE)

$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

$(PDF_FILE): | $(BUILD_PATH)
	@echo "Syncing project into build/src..."
	rm -rf $(SRC_COPY)
	mkdir -p $(SRC_COPY)
	rsync -a --exclude build ./ $(SRC_COPY)/

	@echo "Compiling inside build/src..."
	cd $(SRC_COPY) && \
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE) && \
	$(BIBTEX) $(TEX_SRC_FILE:.tex=) && \
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE) && \
	$(LATEX) $(LATEX_FLAGS) $(TEX_SRC_FILE)

	@echo "Exporting PDF..."
	cp $(SRC_COPY)/book.pdf $(PDF_FILE)

clean:
	rm -rf $(BUILD_PATH)

.PHONY: all clean
