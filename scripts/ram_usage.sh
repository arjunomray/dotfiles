#!/bin/bash
TOTAL_BYTES=$(sysctl -n hw.memsize)
TOTAL_GB=$((TOTAL_BYTES / 1073741824))
USED_GB=$(vm_stat | awk '/Pages active/{a=$3} /Pages wired down/{w=$4} /Pages occupied by compressor/{c=$5} END{printf "%.1f", (a+w+c)*16384/1073741824}')
echo "${USED_GB}G/${TOTAL_GB}G"
