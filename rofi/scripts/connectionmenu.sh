#!/usr/bin/env bash
#
# Rofi power menu for Hyprland.
# Bind this to a keypress or wire it into Waybar's custom/power on-click.

# -- Menu entries (label -> icon) --
WIFI=$'   \udb85\udec6   Wifi'
# SUSPEND="\uf04c"+"   Suspend"
#HIBERNATE="  Hibernate"
BLUETOOTH=$'   \udb80\udcb3   Bluetooth'
AIRPLANEMODE=$'   \uead2   Airplane mode'
VPN=$'   \uf011   VPN connect/disconnect'

# -- Rofi appearance --
ROFI_THEME="$HOME/.config/rofi/connectionmenu.rasi"
ROFI_CMD="rofi -dmenu -i -p Power"
if [ -f "$ROFI_THEME" ]; then
    ROFI_CMD="$ROFI_CMD -theme $ROFI_THEME"
fi

# -- Build and show the menu --
CHOSEN=$(printf '%s\n%s\n%s\n%s\n' \
    "$WIFI" "$BLUETOOTH" "$AIRPLANEMODE" "$VPN" \
    | $ROFI_CMD)

# -- Confirmation prompt for destructive actions --
confirm() {
    local action="$1"
    local answer
    answer=$(printf 'Yes\nNo\n' | rofi -dmenu -i -p "Really $action?")
    [ "$answer" = "Yes" ]
}

case "$CHOSEN" in
    "$WIFI")
        hyprlock &
        ;;
    # "$SUSPEND")
        # systemctl suspend
        # ;;
#    "$HIBERNATE")
 #       confirm "hibernate" && systemctl hibernate
  #      ;;
    "$BLUETOOTH")
        confirm "log out" && hyprctl dispatch exit
        ;;
    "$AIRPLANEMODE")
        confirm "reboot" && systemctl reboot
        ;;
    "$VPN")
        confirm "shut down" && systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
