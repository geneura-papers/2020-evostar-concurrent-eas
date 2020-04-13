#!/bin/bash

for i in {1..15}
do
    filename="logs/lo-t6-${i}.json"
    echo Logging to $filename
    LOG_TIMELINE_JSON_LINES=$filename ./concurrent-ea-leading-ones.p6 --threads=6
done
