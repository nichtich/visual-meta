---
title: Visual-Meta design considerations
date: 2019-10
author:
- Jakob Voß

# pwcite options
link-wikidata-references: true
bibliography:
- references.json
- references.bib
...

This paper summarizes some design considerations of *Visual-Meta*, an approach to visibly embed metadata in documents.

# Introduction

The connection between a document and information *about* it (metadata), is easily lost when the document is copied or converted. Some document formats support embedded metadata such as EXIF in image files and XMP in PDF files, but the quality of this data is usually poor and its is rarely used when referencing the document. The loss of metadata is even more inevitable when a section of a document is copied.  Software for citation management and personal knowledge management such as Zotero and Citavi provide tools to keep track of document metadata but the metadata first has to be provided in some form and second its not kept easily across different tools.

Visual-Meta is an approach to keep the connection between document and metadata by visibly putting the metadata into a document. The idea was presented by @Q72164951 at the Hypertext'19 conference where I first criticized it but then got into a fruitful discussion that eventually led to this document.

# Visual-Meta

In its current, informal specification Visual-Meta is basically a BibTeX entry embedded in a document. The BibTeX entry MUST start with `@` directly followed by the document type^[See @biblatex; section 2.1 for a list of common document types. To allow arbitrary document types, any sequence of letters a to z should be allowed.] and an opening `{`.

In its simplest form for a Visual-Meta record is just a BibTeX entry like this of @Q72167445:

~~~bibtex
@article{
  author = {Douglas Engelbart},
  title = {Augmenting Human Intellect: A Conceptual Framework},
  month = oct, year = {1962}, 
  institution = {SRI}  
}
~~~

A regular expression to catch potential start positions of Visual-Meta records is "`@[a-z]+{`". To extract Visual-Meta from a document a parser needs to find the last of these positions that start a syntactically well-formed BibTeX entry.

## BibTeX format

BibTeX is an outdated legacy format but still the most common format to exchange bibliographic records for citation management. In contrast to more modern alternatives such as CSL-JSON, BibTeX records may at least be familar to some users. Moreover its syntax is relatively condence, extendible and not affected by line breaks.

To process BibTeX format it requires a BibTeX parser. Several BibTeX parsers don't respect the actual BibTeX grammar, as specified in the BibTeX source code.^[Available at <http://ftp.rrze.uni-erlangen.de/ctan/biblio/bibtex/base/bibtex.web>. See <https://github.com/aclements/biblib#recognized-grammar> for a formal grammar.] An extensive description of BibTeX format is included in the biblatex manual (@biblatex; section 2).

BibTeX entries can include custom key-value pairs so Visual-Meta can extend the format with additional fields. Lists of values are supported as "separated value fields" with comma as separator (like supported in standard field `keywords`). Values can optionally be wrapped in braces to support literal commas in fields values. To support nested fields, a custom field can also contain a list of key-value pairs:

~~~bibtex
@type{key,
  simplefield = {field value},
  listfield = {first, {second, with a comma}, third},
  subfields = {key = {value}, listkey = {first, second}}
}
~~~

BibTeX syntax with custom fields can internally be converted to another format such as JSON. BibTeX entry type and optional key should NOT be stored as additional fields `type` and `key` but for instance `entrytype` and `entrykey` (if needed).

Note that extended field values must not contain unbalanced braces. Lists of lists are neither allowed.

## Visual-Meta fields

Non-standard BibTeX fields of Visual-Meta are yet to be specified. Fields proposed in earlier documents about Visual-Meta include:

* document
* citations
* glossary
* visible-meta

Custom Visual-Meta field names must be checked against the biblatex manual [@biblatex] to not collide with existing fields! Some possible Visual-Meta fields are described as following.

<!--
  document = {augmentinghu_douglas_engelbart_19621021231532_6396.pdf},
  (css styled) formatting = { heading level 1 = {Helvetica, 22pt, bold}, heading level 2 = {Helvetica, 18, bold}, body = {Times, 12pt}, image captions = {‘Times, l4, italic, align centre} },
  citations = { inline = {superscript number}, section name = {References}, section format = {author last name, author ﬁrst name, title, date, place, publisher} },
  glossary = { term = {Name of glossary term}, definition = {freeform definition text}, relates to = {relationship – “other term”},  term = {Name of glossary term number two}, definition = {freeform definition text}, relates to = {relationship – “other term”}, },
  special = { name = {DynamicView}, node= {nodcname, location, connections} }
  visible-meta = { version = {1.1}, generator = {Liquid | Author 4.6}, source = {Scholarcy, 2019,08,01} }

Contributing author section marking = Heading level 1, authorname = bold  end next heading

contributing  authors = {Douglas Carl Engelbart, Ted Nelson},
Contibuting orchid = {...}
  fragments = {
     { selector = {...}, author = {Douglas Carl Engelbart} }},
     { selector = {...}, author = {Ted Nelson} } },
  }
}

-->

### orcid

A list of ORCID of authors. This is useful to extend the author field. For instance:

~~~bibtex
@misc{
  author = {Hegland, Frode and Voß, Jakob},
  orcid = {https://orcid.org/0000-0001-5711-1279, https://orcid.org/0000-0002-7613-4123}
}
~~~

Corresponding fields can be used for other name fields, e.g. `editororcid`, `holderorcid`...  The `orcid` field should have the same number of elements like authors listed in the corresponding author field. If an author has no ORCID, an empty list element can be included.

### styles

A list of layout rules how to extract semantic parts from layout.^[The use case is the reverse of application of styles to elements. See <https://stackoverflow.com/q/58503493/373710> fora discussion how to extract document sections based on style.] The syntax of such rules has to be defined. At least layout properties such as font-size, color etc. should be based on corresponding CSS names instead of inventing an additional style language. 

Reverse CSS

~~~bibtex
styles = {
  heading = {font-weight=bold},
  footnote = {font-size=<small}
}
~~~

The style location language might also allow comparision and more complex location such as known from query languages like XPath but it should not be too complex.

### fragments

A list of document fragments such as chapters, transcluded quotes... Identification of fragments is relevant to assign differnt metadata to different parts of the documents.

~~~bibtex
fragments = {
  {selector = ..., author = ...},
  {selector = ..., author = ...}
}
~~~

Each fragment is identfied by a `selector` to reference the fragment by an existing locating method ([Web annotation selectors](https://www.w3.org/TR/annotation-model/#selectors), purple numbers...).

## Copy & Paste with Visual-Meta

Two possible variants:

* Append the BibTeX entry to the raw text (Visual-Meta)
* Add BibTeX entry as additional format into the clipboard (non-visual metadata)

# References

