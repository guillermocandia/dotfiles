#!/bin/bash

speakers_name="Built-in Audio Analog Surround 2.1"
headphones_name="G733 Gaming Headset Analog Stereo"
speakers_icon="🔈"
headphones_icon="🎧"
mute_color="red"
active_color="cyan"

valid_devices=("speakers" "headphones")

if [ $# -eq 0 ]; then
    echo "Error: No device provided."
    echo "Usage: $0 <device>"
    exit 1
fi

valid_argument=false
for valid_arg in "${valid_devices[@]}"; do
    if [ "$1" = "$valid_arg" ]; then
        valid_argument=true
        break
    fi
done

if ! $valid_argument; then
    echo "Error: Invalid device. Device must be one of the following: ${valid_devices[@]}"
    exit 1
fi

if [ "$1" = "speakers" ]; then
    sink=$(pulsemixer --list-sinks|grep "$speakers_name"|cut --delimiter "," --fields 1|cut --delimiter " " --fields 3)
    icon=$speakers_icon
else
    sink=$(pulsemixer --list-sinks|grep "$headphones_name"|cut --delimiter "," --fields 1|cut --delimiter " " --fields 3)
    icon=$headphones_icon
fi

volume_values=$(pulsemixer --id "$sink" --get-volume)
mute=$(pulsemixer --id "$sink" --get-mute)

total=0
count=0
for volume in $volume_values; do
    total=$((total + volume))
    count=$((count + 1))
done

average=$((total / count))

if [ $mute -eq 1 ] || [ $volume -eq 0 ]; then
    color=$mute_color
else
    color=$active_color
fi

echo "<fn=1>$icon</fn><fc=$color>$average</fc>"
