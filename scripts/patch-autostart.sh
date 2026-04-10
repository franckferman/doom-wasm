#!/bin/bash
# Apply or revert the autostart patch (skip menus, launch directly into E1M1)

set -e
SRC="doomgeneric/src/d_main.c"

case "${1:-apply}" in
    apply)
        if grep -q "autostart = true" "$SRC"; then
            echo "Already patched."
            exit 0
        fi
        sed -i 's/autostart = false;/autostart = true; \/\/ KatanHack: skip menus, auto-start E1M1/' "$SRC"
        echo "Patch applied: autostart = true"
        ;;
    revert)
        if grep -q "autostart = false;" "$SRC"; then
            echo "Already reverted."
            exit 0
        fi
        sed -i 's/autostart = true;.*/autostart = false;/' "$SRC"
        echo "Patch reverted: autostart = false"
        ;;
    *)
        echo "Usage: $0 [apply|revert]"
        exit 1
        ;;
esac
