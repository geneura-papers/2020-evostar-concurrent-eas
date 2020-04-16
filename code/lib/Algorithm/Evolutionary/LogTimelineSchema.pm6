unit module Algorithm::Evolutionary::LogTimelineSchema;

use Log::Timeline;

class Events does Log::Timeline::Event['ConcurrentEA', 'Events', 'Events'] { }

class Weird does Log::Timeline::Event['ConcurrentEA', 'Events', 'Weird']
{ }
class Generations
        does Log::Timeline::Event['ConcurrentEA', 'Events', 'Generations'] { }

class GenerationsStart
        does Log::Timeline::Event['ConcurrentEA',
                                    'Events',
                                    'GenerationsStart'] { }

class SolutionFound
        does Log::Timeline::Event['ConcurrentEA', 'Events','SolutionFound']  { }

class Frequencies
        does Log::Timeline::Event['ConcurrentEA', 'Events','Frequencies'] { }

class Evolutionary does Log::Timeline::Task['ConcurrentEA', 'Concurrent',
        'Evolutionary'] { }

class Disturbance does Log::Timeline::Task['ConcurrentEA', 'Concurrent',
        'Disturbance'] { }

class Mixer does Log::Timeline::Task['ConcurrentEA', 'Concurrent',
        'Mixer'] { }