docs/index.html: paper.md
	pandoc -F pwcite -F pandoc-citeproc -s --template template/template.html --natbib \
	   $< -o $@
