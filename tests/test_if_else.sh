#!/bin/bash
# Test: Simple if-else condition

age=25

if [ $age -lt 18 ]; then
    echo "Minor"
else
    echo "Adult"
fi
