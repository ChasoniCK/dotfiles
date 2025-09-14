battery=$(acpi -b | grep -o '[0-9]\+%')

echo $battery
