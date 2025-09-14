# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT1/capacity)

# Define the battery icons for each 10% segment
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))

if [ "$icon_index" -eq 10 ]; then
  	icon_index=9
fi

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Output the battery percentage and icon
echo "$battery_icon $battery_percentage%"
