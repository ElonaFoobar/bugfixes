PANDOC := pandoc

DOCS_DIR := docs
DOCUMENT := $(DOCS_DIR)/index.html
STYLE := $(DOCS_DIR)/style.css

FILTER_DIR := filter
FILTERS := $(FILTER_DIR)/hoge.rb

SOURCE_DIR := src
SOURCES := $(SOURCE_DIR)/*.md


all: $(DOCUMENT)


$(DOCUMENT): $(SOURCES) $(STYLE) $(FILTERS)
	$(PANDOC) \
		--from=markdown --to=html5 \
		--standalone \
		--filter $(FILTERS) \
		--css=$(STYLE) \
		--output=$@ \
		$(SOURCES)


clean:
	$(RM) -f $(DOCUMENT)


.PHONY: all clean
