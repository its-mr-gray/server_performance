#!/bin/bash

function memory_usage {
  local mem=$1
  free -m | awk -v var="$mem" 'NR==2{printf "%.2f", $var/1000 } '
}

function memory_percentage {
  local free_mem=$1
  local used_mem=$2
  free -m | awk -v var1="$free_mem" -v var2="$used_mem" 'NR==2{printf "%.2f%", $var1*100/$var2 }'
}

function disk_usage {
  local cpu=$1
  df -h | awk -v var="$cpu" '$NF=="/"{printf "%s", $var }'
}

function total_cpu_usage {
  top -bn1 | grep "load" | awk '{printf "%.2f%", $(NF-2) } '
}

function top_5_cpu_memory {
  top -bn1 --sort-override %MEM | head -n 12 | tail -5 | awk '{print $NF}'
}

function top_5_cpu {
  top -bn1 | head -n 12 | tail -5 | awk '{print $NF}'
}

echo "Free Memory:
$(memory_usage 4)G  
Used Memory: 
$(memory_usage 3)G 
Percentage of Memory Currently In Use: 
$(memory_percentage 3 2)
Free Disk Space: 
$(disk_usage 4) 
Used Disk Space: 
$(disk_usage 3)
Percentage of Disk Space Used: 
$(disk_usage 5)
Current CPU Usage: 
$(total_cpu_usage)
Top 5 Processes by CPU Usage:
$(top_5_cpu)
Top 5 Processes by Memory Usage:
$(top_5_cpu_memory)"
