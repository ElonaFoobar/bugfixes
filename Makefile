DOCS_DIR := docs
PANDOC := pandoc



all: $(DOCS_DIR)/index.html


$(DOCS_DIR)/index.html: *.md $(DOCS_DIR)/style.css
	$(PANDOC) --from=gfm --to=html5 --output=$@ --css=$(DOCS_DIR)/style.css README.md *-*.md


clean:
	$(RM) -f $(DOCS_DIR)/index.html



.PHONY: all clean
