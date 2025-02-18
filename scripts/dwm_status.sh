#!/bin/bash

# Function to get volume level
get_volume() {
    # Get the current volume level
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d. -f1)

    # Check if the audio is muted
    mute_status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
    if [[ "$mute_status" == "[MUTED]" ]]; then
        echo "Vol: $volume% (Muted)"
    else
        echo "Vol: $volume%"
    fi
}

# Function to get brightness level
get_brightness() {
    brightness=$(brightnessctl | grep -o "[0-9]*%" | head -1)
    echo "Bri: $brightness"
}

get_time() {
    echo "$(date +'%H:%M')"
}

# Function to get connection name (assuming you're using NetworkManager)
get_connection() {
    connection=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    if [ -z "$connection" ]; then
        connection="Wired"
    fi
    echo "Net: $connection"
}

# Function to get battery level
get_battery() {
    battery_info=$(upower -i $(upower -e | grep BAT))
    battery_level=$(echo "$battery_info" | grep percentage | awk '{print $2}')
    battery_state=$(echo "$battery_info" | grep state | awk '{print $2}')
    battery_plugged=$(echo "$battery_info" | grep "power supply" | awk '{print $4}')

    if [[ "$battery_plugged" == "yes" ]]; then
        if [[ "$battery_state" == "fully-charged" ]]; then
            echo "Bat: $battery_level (Charged)"
        elif [[ "$battery_state" == "charging" ]]; then
            echo "Bat: $battery_level (Charging)"
        else
            echo "Bat: $battery_level"
        fi
    else
        echo "Bat: $battery_level"
    fi
}

# Function to update the status bar
update_status() {
    volume=$(get_volume)
    brightness=$(get_brightness)
    connection=$(get_connection)
    battery=$(get_battery)
    time=$(get_time)

    # Combine all information into a single string
    status=" $volume | $brightness | $connection | $battery "

    # Update the DWM status bar
    xsetroot -name "$status"
}

# Main loop to update the status bar
while true; do
  
    update_status	

    # Wait for a few seconds before updating again
    sleep 5
done
