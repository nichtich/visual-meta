docs/index.html: paper.md
	pandoc -F pwcite -F pandoc-citeproc $< -o $@ -s
