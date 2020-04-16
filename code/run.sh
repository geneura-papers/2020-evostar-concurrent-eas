#!/bin/bash

for j in {2,4,6}
do
   for i in {1..15}
     do
        filename="logs/lo-dis-p512-t${j}-${i}.json"
        echo Logging to $filename
        LOG_TIMELINE_JSON_LINES=$filename ./concurrent-ea-leading-ones.p6 --total-population=1024 --threads=$j --length=60
     done
done
