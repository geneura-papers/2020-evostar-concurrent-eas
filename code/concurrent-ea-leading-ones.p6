#!/usr/bin/env perl6

use v6;

use lib <../../lib lib>;

use Algorithm::Evolutionary::Simple;
use Algorithm::Evolutionary::LogTimelineSchema;
use Log::Timeline::Output::JSONLines;

constant \log-file = ("lo-pma-" ~ DateTime.now.Str ~ ".json").IO;

use Log::Timeline;

use JSON::Fast;

sub MAIN(
        UInt :$length = 50,
        UInt :$total-population = 256,
        UInt :$generations = 16,
        UInt :$threads = 4,
        UInt :$time-limit = 1200
    ) {

    my $parameters = .Capture;
    my $population-size = ($total-population/$threads).floor;
    my Channel $channel-one .= new;
    my Channel $to-mix .= new;
    my Channel $mixer = $to-mix.Supply.batch( elems => 2).Channel;
    my atomicint $evaluations = 0;
    my $max-fitness = $length;

    Algorithm::Evolutionary::LogTimelineSchema::Events.log();
    my $initial-populations = $threads + 1;
    Algorithm::Evolutionary::LogTimelineSchema::Events.log( { :$length,
                    :$population-size,
                    :$initial-populations,
                    :$generations,
                    :$threads,
                    start-at => DateTime.now.Str} );

    # Initialize three populations for the mixer
    for ^$initial-populations {
        $channel-one.send( 1.rand xx $length );
    }

    my @promises;
    for ^$threads {
        my $promise = start react whenever $channel-one -> @crew {
            Algorithm::Evolutionary::LogTimelineSchema::Evolutionary.log: {
                my %fitness-of;
                Algorithm::Evolutionary::LogTimelineSchema::Frequencies
                        .log( :@crew );
                my @unpacked-pop = generate-by-frequencies( $population-size, @crew );
                my $population = evaluate( population => @unpacked-pop,
                                            :%fitness-of,
                                            evaluator => &leading-ones);
                Algorithm::Evolutionary::LogTimelineSchema::GenerationsStart
                        .log( :population-size(@unpacked-pop.elems),
                              :distinct-elements( %fitness-of.keys.elems) );
                my atomicint $count = 0;
                while ($count⚛++ < $generations) &&
                        (best-fitness($population) < $max-fitness) {
                    LAST {
                        if best-fitness($population) >= $max-fitness {
                            Algorithm::Evolutionary::LogTimelineSchema::SolutionFound
                                    .log(
                                    {
                                        id => $*THREAD.id,
                                        best => best-fitness($population),
                                        found => True,
                                        finishing-at => DateTime.now.Str
                                    }
                                    );

                            say "Solution found" => $evaluations;
                            Algorithm::Evolutionary::LogTimelineSchema::SolutionFound
                                    .log( :$evaluations );
                            $channel-one.close;
                        } else {
                            say "Emitting after $count generations in thread ",
                                    $*THREAD.id, " Best fitness ",best-fitness($population);
                            if  $count < $generations {
                                Algorithm::Evolutionary::LogTimelineSchema::Weird
                                        .log(  id => $*THREAD.id,
                                                best => best-fitness($population),
                                                :$count,
                                                :population-size(@unpacked-pop.elems),
                                                :distinct-elements( %fitness-of.keys.elems)
                                        );
                            } else {
                                Algorithm::Evolutionary::LogTimelineSchema::Events.log(
                                        id => $*THREAD.id,
                                        best => best-fitness($population),
                                        :$count
                                        );
                            }
                            $to-mix.send( frequencies-best($population, 8) );
                        }
                    };
                    $population = generation( :$population, :%fitness-of,
                            evaluator => &leading-ones,
                            :$population-size
                            );
                    $evaluations ⚛+= $population.elems;
                }
                Algorithm::Evolutionary::LogTimelineSchema::Generations
                        .log( :generations($count),
                              individuals => %fitness-of.keys.elems);
                $evaluations;
            };
        };
        @promises.push: $promise;

    }

    my $pairs = start react whenever $mixer -> @pair {
        Algorithm::Evolutionary::LogTimelineSchema::Mixer.log: {
            $to-mix.send( @pair.pick );
            # To avoid getting it hanged up
            my @new-population =  crossover-frequencies( @pair[0], @pair[1] );
            $channel-one.send( @new-population);
            say "Mixing in ", $*THREAD.id;
        }
    };

    start {
        sleep $time-limit;
        say "Reached time limit";
        Algorithm::Evolutionary::LogTimelineSchema::Events.log( :not-found(True) );
        exit
    };   # Just in case it gets stuck
    await @promises;
    say "Parameters ==";
    say "Evaluations => $evaluations";
    for $parameters.kv -> $key, $value {
        say "$key → $value";
    };
    say "=============";
}
