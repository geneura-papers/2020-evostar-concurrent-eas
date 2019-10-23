unit module Algorithm::Evolutionary::LogTimelineSchema;

use Log::Timeline;

class Events does Log::Timeline::Event['ConcurrentEA', 'Events', 'EA'] { }

class Evolutionary does Log::Timeline::Task['ConcurrentEA', 'Concurrent',
        'Evolutionary'] { }

class Mixer does Log::Timeline::Task['ConcurrentEA', 'Concurrent',
        'Mixer'] { }