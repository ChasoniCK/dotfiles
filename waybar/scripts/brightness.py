#!/usr/bin/env python3
import subprocess

def get_brightness():
    result = subprocess.run(
        ["brightnessctl", "get"],
        capture_output=True,
        text=True,
        check=True
    )
    current = int(result.stdout.strip())

    # Получаем максимальную яркость
    max_result = subprocess.run(
        ["brightnessctl", "max"],
        capture_output=True,
        text=True,
        check=True
    )
    maximum = int(max_result.stdout.strip())

    percent = int((current / maximum) * 100)
    return f"{percent}%"
        
if __name__ == "__main__":
    print(get_brightness())
