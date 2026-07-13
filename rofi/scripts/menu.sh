#!/usr/bin/env bash
#
# Rofi power menu for Hyprland.
# Bind this to a keypress or wire it into Waybar's custom/power on-click.

# -- Menu entries (label -> icon) --
APPS=$' \udb80\udc3b  APPS'
WIFI=$' \udb85\udec6  WIFI'
BLUETOOTH=$' \udb80\udcb3  BLUETOOTH'
AUDIO=$' \ue638  AUDIO'
MONITORS=$' \udb84\udec6  MONITORS'
KEYBOARD=$' \udb82\uddf9  KEYBOARD'
MOUSE=$' \udb80\udf7d  MOUSE'
SESSION=$' \uf011  System'



# -- Rofi appearance --
ROFI_THEME="$HOME/.config/rofi/menu.rasi"
ROFI_CMD="rofi -dmenu -i -p Go..."
if [ -f "$ROFI_THEME" ]; then
    ROFI_CMD="$ROFI_CMD -theme $ROFI_THEME"
fi

# -- Build and show the menu --
CHOSEN=$(printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' \
    "$APPS" "$WIFI" "$BLUETOOTH" "$AUDIO" "$MONITORS" "$KEYBOARD" "$MOUSE" "$SESSION" \
    | $ROFI_CMD)

# -- Confirmation prompt for destructive actions --
# confirm() {
    # local action="$1"
    # local answer
    # answer=$(printf 'Yes\nNo\n' | rofi -dmenu -i -p "Really $action?")
    # [ "$answer" = "Yes" ]
# }

case "$CHOSEN" in
    "$APPS")
        
        ;;
    "$WIFI")

        ;;
    "$BLUETOOTH")

        ;;
    "$AUDIO")

        ;;
    "$MONITORS")

        ;;
    "$KEYBOARD")

        ;;
    "$MOUSE")

        ;;
    "$SESSION")
        
        ;;
    *)
        exit 0
        ;;
esac
