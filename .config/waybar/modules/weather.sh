#!/bin/bash
report=$(curl -q v2d.wttr.in/?format=1 2>/dev/null)
if [[ $report =~ "Unknown location" || $report =~ "Sorry" ]]; then
    report="No data"
fi
echo $report
