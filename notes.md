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

1. _human-readable_. This forbids binary formats such as list of hexadecimal digits or QR-Codes.

2. _machine-readable_. Therefore

    2.1. The metadata section must be automatically be separable from the rest of the document.    
    2.2. The format must formally be specified

3. _hackable_ for easy creation, extraction, and processing. This means:

    3.1. The format should be based on commons standards as much as possible
    
    3.2. The format should not require complex parsing and encoding rules

4. _condense_ to not take too much space. One feature derived from this requirements is the format should not depend on newlines and allow line wrapping.

## Data modeling

Every data format is the product of an (possibly implicit) data modeling process from

A) a conceptual model (which information should be transfered)

B) a serialization format (e.g. JSON, YAML, CSV, XML, RDF...)

D) an encoding (how to use the serialization format, e.g. which fields in which order etc.)

