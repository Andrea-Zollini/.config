#!/bin/bash

# Check the current WiFi status
status=$(nmcli radio wifi)

if [ "$status" = "enabled" ]; then
    # Turn WiFi off
    nmcli radio wifi off
else
    # Turn WiFi on
    nmcli radio wifi on
fi
