#!/usr/bin/env perl
use v5.14;
use BibTeX::Parser;
use JSON::PP;

my $parser = BibTeX::Parser->new(*STDIN);
while ( my $entry = $parser->next ) {
    if ( $entry->parse_ok ) {
        say $entry->to_string;
    }
    else {
        warn "Error parsing file: " . $entry->error;
    }
}
