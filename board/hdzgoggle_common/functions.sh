function ensure_line() {
    LINE="$1"
    FILE="$2"
    grep -q "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
}

function align_size() {
    local SIZE=$1
    if (($SIZE % 65536 != 0)); then
        SIZE=$(($SIZE / 65536 + 1))
        SIZE=$(($SIZE * 65536))
    fi
    echo "$SIZE"
}

function align_size_down() {
    local SIZE=$1
    if (($SIZE % 65536 != 0)); then
        SIZE=$(($SIZE / 65536))
        SIZE=$(($SIZE * 65536))
    fi
    echo "$SIZE"
}