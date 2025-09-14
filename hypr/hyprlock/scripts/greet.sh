#!/usr/bin/env bash
set -euo pipefail

CFG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock/greeting"
mkdir -p "$CFG_DIR"
OUT="$CFG_DIR/greeting.txt"
LOCK="$CFG_DIR/greeting.lock"

# Могут выпасть всегда
general_greetings=(
#     "Привет, ChasoniCK."
    "Добро пожаловать!"
#     "Приятно видеть тебя, ChasoniCK."
#     "Всё будет хорошо."
)

# Утро
morning_greetings=(
    "Доброе утро!"
    "Новый день новые возможности."
    "День в твоих руках."
)

# День
day_greetings=(
    "Добрый день!"
    "Хорошего дня, ChasoniCK!"
    "Продолжим?"
)

# Вечер
evening_greetings=(
    "Добрый вечер!"
    "Как прошёл твой день?"
    "День подходит к концу, но ещё не кончился."
)

# Ночь
night_greetings=(
    "Спокойной ночи."
    "Сон? - не слышал."
    "Не пора ли спать?"
)

# --- Логика выбора приветствия ---

hour=$(date +%H)
minute=$(date +%M)
hour=${hour#0}
minute=${minute#0}

exec 9>"$LOCK"
flock 9

# Проверяем, совпадает ли приветствие с текущим часом
if [ -f "$OUT" ]; then
    saved_hour=$(head -n1 "$OUT" | cut -d'|' -f1 || echo "")
    if [ "$saved_hour" = "$hour" ]; then
        cut -d'|' -f2- "$OUT"
        exit 0
    fi
fi

# Выбираем пул
if (( RANDOM % 4 == 0 )); then
    pool=( "${general_greetings[@]}" )
else
    if (( hour >= 5 && hour <= 11 )); then
        pool=( "${morning_greetings[@]}" )
    elif (( hour >= 12 && hour <= 17 )); then
        pool=( "${day_greetings[@]}" )
    elif (( hour >= 18 && hour <= 22 )); then
        pool=( "${evening_greetings[@]}" )
    else
        pool=( "${night_greetings[@]}" )
    fi
fi

greeting="${pool[$RANDOM % ${#pool[@]}]}"

# Записываем в файл час + текст
printf "%s|%s\n" "$hour" "$greeting" > "$OUT"
echo "$greeting"
