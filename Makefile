PANDOC := pandoc

DOCS_DIR := docs
DOCUMENT := $(DOCS_DIR)/index.html
STYLE_RELATIVE := sakura.css
STYLE := $(DOCS_DIR)/$(STYLE_RELATIVE)

FILTER_DIR := filter
FILTERS := $(FILTER_DIR)/hsphighlighter.rb

SOURCE_DIR := src
SOURCES := $(SOURCE_DIR)/*.md


all: $(DOCUMENT)


$(DOCUMENT): $(SOURCES) $(STYLE) $(FILTERS)
	$(PANDOC) \
		--from=markdown --to=html5 \
		--standalone \
		--toc --toc-depth=2 \
		--filter $(FILTERS) \
		--css=$(STYLE_RELATIVE) \
		--output=$@ \
		$(SOURCES)


clean:
	$(RM) -f $(DOCUMENT)


.PHONY: all clean
