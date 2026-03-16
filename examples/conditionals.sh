#!/bin/bash
# Conditionals example

age=25

if [ $age -lt 18 ]; then
    echo "Minor"
elif [ $age -lt 65 ]; then
    echo "Adult"
else
    echo "Senior"
fi

case $1 in
    start)
        echo "Starting..."
        ;;
    stop)
        echo "Stopping..."
        ;;
    *)
        echo "Usage: start|stop"
        ;;
esac
