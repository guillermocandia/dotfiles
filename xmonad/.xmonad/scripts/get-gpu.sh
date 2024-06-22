#!/bin/bash

gpu_info=$(nvidia-smi --query-gpu "utilization.gpu,utilization.memory,temperature.gpu,fan.speed" --format=csv,noheader,nounits)

read -r gpu_utilization memory_utilization gpu_temperature fan_speed <<<${gpu_info//[,]}

echo "GPU: $gpu_utilization%|$gpu_temperatureºC|$memory_utilization%|$fan_speed%"
