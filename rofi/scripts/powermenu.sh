#!/usr/bin/env bash
#
# Rofi power menu for Hyprland.
# Bind this to a keypress or wire it into Waybar's custom/power on-click.

# -- Menu entries (label -> icon) --
LOCK=$'   \uf023    Lock'
SUSPEND=$'   \uf4ee    Suspend'
RELAUNCH=$'   \uf359    Relaunch'
REBOOT=$'   \uead2    Restart'
SHUTDOWN=$'   \uf011    Shutdown'

# -- Rofi appearance --
ROFI_THEME="$HOME/.config/rofi/powermenu.rasi"
ROFI_CMD="rofi -dmenu -i -p System..."
if [ -f "$ROFI_THEME" ]; then
    ROFI_CMD="$ROFI_CMD -theme $ROFI_THEME"
fi

# -- Build and show the menu --
CHOSEN=$(printf '%s\n%s\n%s\n%s\n%s\n' \
    "$LOCK" "$SUSPEND" "$RELAUNCH" "$REBOOT" "$SHUTDOWN" \
    | $ROFI_CMD)

# -- Confirmation prompt for destructive actions --
confirm() {
    local action="$1"
    local answer
    answer=$(printf 'Yes\nNo\n' | rofi -dmenu -i -p "Really $action?")
    [ "$answer" = "Yes" ]
}

case "$CHOSEN" in
    "$LOCK")
        hyprlock &
        ;;
    "$SUSPEND")
        systemctl suspend
        ;;
   "$RELAUNCH")
       confirm "relaunch" && hyprctl dispatch exit && start-hyprland
       ;;
    "$REBOOT")
        confirm "reboot" && systemctl reboot
        ;;
    "$SHUTDOWN")
        confirm "shut down" && systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
