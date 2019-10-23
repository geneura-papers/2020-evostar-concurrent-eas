unit module Algorithm::Evolutionary::LogTimelineSchema;

use Log::Timeline;

class Events does Log::Timeline::Event['ConcurrentEA', 'App', 'Log'] { }

