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

1. __human-readable__. This forbids binary formats such as list of hexadecimal digits or QR-Codes.

2. __machine-readable__. Therefore

    2.1. The metadata section must be automatically be separable from the rest of the document.    
    2.2. The format must formally be specified

3. __hackable__ for easy creation, extraction, and processing. This means:

    3.1. The format should be based on commons standards as much as possible    
    3.2. The format should be simple and (not too many parts, not require complex parsing and encoding rules)

4. __condense__ to not take too much space. One feature derived from this requirements is the format should not depend on newlines and allow line wrapping.

## Data modeling

Every data format is the product of an (possibly implicit) data modeling process from

A) __conceptual model__ (which information should be transfered) with

B) __data structuring format__ (e.g. JSON, YAML, CSV, XML, RDF...) to

D) __serialization__ (how to use the serialization format, e.g. which fields in which order etc.)

Visual-Meta contains of bibliographic metadata about the document (author, title, date...) and information about its content (_whatever this is, this needs some clarification_). Several bibliographic data formats exist to build on (requirement 3.1). With Requirment 3.2 in mind there is only:

* BibTeX (very common but complex especially names and non-Latin scripts)
* YAML-Header fields (`title`, `author` (string or list of strings), `date` (YYYY-MM-DD))

Requirement 3 recommends to use an existing data structuring format format. Requirements 3.2 and 4 lead to JSON without line breaks (the JSON document can be split over multiple lines but line breaks must be ignored when parsing). To further simplify the format and allow for minor syntactical errors Visual-Meta MAY also be expressed in [JSON5](https://json5.org/), a simplified syntax of JSON.

Requirement 2.1. could be solved with a separator such as `----` or `VISUAL-META` before and after the JSON data. It is also possible without such separator if the JSON/JSON5 section always starts with a known field name, e.g. "`Visual-Meta`". 

The `Visual-Meta` field could contain basic bibliographic metadata in YAML-Header format (`title`, `author`, `date`), additional metadata can be put in additional fields (to be defined).

## Example

JSON:

~~~
This is a document.

{ "Visual-Meta": { "author": "author name", "title": "title 
of document", "date": "2020-01-01" }, "custom": 12345 }

Some more content.
~~~

JSON5:

~~~
This is a document.

{ Visual-Meta: { author: "author name", title: "title 
of document", date: 2020-01-01 } }

Some more content.
~~~

Extraction of Visual-Meta (JSON) from a document, implemented in JavaScript:

~~~js
function extractVisualMeta(doc) {
  const pos = doc.search(/{\s*"Visual-Meta"/)
  if (pos >= 0) {
    try {
      return JSON.parse(doc.substr(pos))
    } catch(e) { // ignore document content after metadata
      return JSON.parse(doc.substr(pos,e.message.split(' ').pop()))
    }
  }
}
~~~

