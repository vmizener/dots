op=$(
    echo -e " Lock\n Logout\n Suspend\n Poweroff\n↺ Reboot" \
    | wofi -i --dmenu -W 75 -L 5 \
    | awk '{print tolower($2)}'
)

case $op in
    poweroff)
        ;&
    reboot)
        ;&
    suspend)
        systemctl $op
        ;;
    lock)
        swaylock
        ;;
    logout)
        swaymsg exit
        ;;
esac
