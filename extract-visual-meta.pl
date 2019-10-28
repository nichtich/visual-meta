#!/usr/bin/env perl
use v5.14;
use BibTeX::Parser;
use IO::String;
use JSON::PP;

sub extract_visual_meta {
    my ($doc) = @_;

    state $types = join '|', qw(
      article book booklet conference inbook incollection inproceedings
      manual mastersthesis misc phdthesis proceedings techreport unpublished
    );

    # collect start positions of possible BibTeX entries in reverse order
    my @pos;
    unshift @pos, pos($doc) - length $1 while $doc =~ /(@($types){)/mg;

    # try to parse each possible entry (starting with the last one)
    for (@pos) {
        my $substr = IO::String->new( substr $doc, $_ );
        my $entry = BibTeX::Parser->new($substr)->next;
        return $entry if $entry && $entry->parse_ok;
    }
}

# get document from STDIN
my $doc = join "\n", <>;
if ( my $entry = extract_visual_meta($doc) ) {
    $entry->key('') unless defined $entry->key;    # avoid warning
    say $entry->to_string( type_capitalization => 'Lowercase' );
}
