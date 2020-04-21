#!/usr/bin/env perl6

use JSON::Fast;

my %results;

my $dir = @*ARGS[0] // "logs";

say "Type, Threads, Time, Evaluations";
for dir($dir, test => /'.' json $/) -> $f {
    my $match-type = $f ~~ /"lo-"(\S+)"-p"/;
    my $type = $match-type??~$match-type[0]!!"nodis";
    my $threads = ~($f ~~ /t(\d+)/)[0];
    my @lines = $f.IO.lines.map: { from-json $_};
    my @events = @lines.grep: *<n> eq 'Events';
    my $start = DateTime.new(@events[1]<t>);
    my @solutions = @lines.grep: *<n> eq 'SolutionFound';
    next if ! @solutions;
    say @solutions[1];
    my $end = DateTime.new(@solutions[1]<t>);
    say "$type, $threads, ", $end - $start, ", ", @solutions[1]<d><evaluations>;
}