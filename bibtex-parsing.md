# Parsing BibTeX from documents

BibTeX is a widely used legacy format used to transport bibliographic data for citation management. A modern alternative is CSL-JSON but converters exist to transform between the two.

BibTeX format is incompletely described at <http://www.bibtex.org/Format/>. A more formal description [can be found here](https://github.com/aclements/biblib#recognized-grammar).

BibTeX can contain custom fields. Field values must not contain unbalanced braces (`{`...`}`).

The start of a BibTeX entry can be detected with the regular expression `@[a-z]+{`. This is more strict than the full BibTeX grammar but captures how BibTeX is used in practice. The expression could be more strict with a list of entry types, e.g. `@(article|inproceedings|...){)`.

The end of the entry can be found by counting braces `{` and `}`.

A BibTeX appending is included:

@misc{
  title={Parsing BibTeX from documents},
  custom={This is a {custom} field}
}


