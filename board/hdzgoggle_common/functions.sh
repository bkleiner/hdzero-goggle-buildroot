function ensure_line() {
    LINE="$1"
    FILE="$2"
    grep -q "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
}