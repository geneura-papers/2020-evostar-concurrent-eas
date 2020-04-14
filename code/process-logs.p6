#!/usr/bin/env perl6

use JSON::Fast;

my %results;

for dir("logs", test => /'.' json $/) -> $f {
    my @lines = $f.IO.lines.map: { from-json $_};
    my @events = @lines.grep: *<n> eq 'EndRun';
    say @events;
}