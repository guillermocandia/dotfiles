#!/bin/bash

speakers_name="Built-in Audio Analog Surround 2.1"
headphones_name="G733 Gaming Headset Analog Stereo"

valid_devices=("speakers" "headphones")

if [ $# -ne 2 ]; then
    echo "Error: Incorrect number of arguments provided."
    echo "Usage: $0 [device] [volume]"
    exit 1
fi

if [[ ! " ${valid_devices[@]} " =~ " $1 " ]]; then
    echo "Error: Invalid device. Device must be one of the following: ${valid_devices[@]}"
    exit 1
fi

if ! [[ "$2" =~ ^[-+]?[0-9]+$ ]]; then
    echo "Error: Invalid volume."
    exit 1
fi

if [ "$1" = "speakers" ]; then
    sink=$(pulsemixer --list-sinks | grep "$speakers_name" | cut --delimiter "," --fields 1 | cut --delimiter " " --fields 3)
else
    sink=$(pulsemixer --list-sinks | grep "$headphones_name" | cut --delimiter "," --fields 1 | cut --delimiter " " --fields 3)
fi

pulsemixer --id "$sink" --change-volume "$2"

exit 0
