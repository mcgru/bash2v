#!/bin/bash
# Test: While loop

count=0
while [ $count -lt 3 ]; do
    echo "Count: $count"
    ((count++))
done
