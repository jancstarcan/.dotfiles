export PATH="$HOME/.local/bin/:$PATH"
export MAKEFLAGS="-j$(nproc)"

if [[ $(tty) == "/dev/tty1" && -z $WAYLAND_DISPLAY ]]; then
    exec dbus-run-session start-hyprland
elif [[ $(tty) == "/dev/tty2" && -z $WAYLAND_DISPLAY ]]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    exec dbus-run-session sway
elif [[ $(tty) == "/dev/tty3" && -z "$DISPLAY" ]]; then
    #startx
fi

export QT_QPA_PLATFORMTHEME="qt5ct;qt6ct"
