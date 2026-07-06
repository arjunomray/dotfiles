#!/bin/bash
# Cache weather for 30 minutes to avoid hammering wttr.in
CACHE_FILE="/tmp/tmux_weather_cache"
CACHE_AGE=1800  # 30 minutes in seconds

if [ -f "$CACHE_FILE" ]; then
    AGE=$(( $(date +%s) - $(stat -f %m "$CACHE_FILE") ))
    if [ "$AGE" -lt "$CACHE_AGE" ]; then
        cat "$CACHE_FILE"
        exit 0
    fi
fi

RESULT=$(curl -s --max-time 5 "wttr.in/?format=%c+%t" 2>/dev/null)
if [ -n "$RESULT" ]; then
    echo "$RESULT" > "$CACHE_FILE"
    echo "$RESULT"
else
    # Return cached value if fetch failed
    [ -f "$CACHE_FILE" ] && cat "$CACHE_FILE" || echo "N/A"
fi
