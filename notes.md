# Visual-Meta data format

This document discusses specification of a data format for [Visual-Meta](http://wordpress.liquid.info/06/visual-meta/).

## What is Visual-Meta?

Visual-Meta is an approach to make document’s metadata machine and human readable. It is developed by Frode Hegland as part of is PhD.

The basic idea is to add metadata as appendix to the end of a document.

## Related data formats

* _Internal Metadata_: Several document formats (EXIF, PDF...) support to store metadata as part of a document but this data is not visible.
* _YAML-Header_: Document formats such as [R Markdown](https://bookdown.org/yihui/rmarkdown/markdown-document.html) and [Pandoc Markdown](https://pandoc.org/MANUAL.html#extension-yaml_metadata_block) support metadata in YAML format in front of a document. As long as the document is processed in source format, this is visual metadata but the documents are mainly used as source to create other document formats.

## Requirements

The format should be 

1. _human-readable_
2 _machine-readable_
3. _hackable_ for easy creation, extraction, and processing
4. _condense_ to not take too much space
