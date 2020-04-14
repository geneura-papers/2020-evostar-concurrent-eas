#!/usr/bin/env perl6

use JSON::Fast;

my %results;

my $dir = @*ARGS[0] // "logs";

say "Population, Threads, Time, Evaluations";
for dir($dir, test => /'.' json $/) -> $f {
    my $population = ($f ~~ /p\d+/)??512!!256;
    my $threads = ~($f ~~ /t(\d)/)[0];
    my @lines = $f.IO.lines.map: { from-json $_};
    my @events = @lines.grep: *<n> eq 'Events';
    my $start = DateTime.new(@events[1]<t>);
    my @solutions = @lines.grep: *<n> eq 'SolutionFound';
    next if ! @solutions;
    my $end = DateTime.new(@solutions[*-1]<t>);
    say "$population, $threads, ", $end - $start, ", ", @solutions.tail<d><evaluations>;
}