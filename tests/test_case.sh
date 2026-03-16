#!/bin/bash
# Test: Case statement

cmd="start"

case $cmd in
    start)
        echo "Starting..."
        ;;
    stop)
        echo "Stopping..."
        ;;
    *)
        echo "Unknown command"
        ;;
esac
