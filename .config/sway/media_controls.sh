#!/usr/bin/env bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# shellcheck source=./lib.sh
source "$SCRIPTPATH/lib.sh"

lib::init

WOBSOCK="$XDG_RUNTIME_DIR/wob.sock"
for i in "$@"; do
    case $i in
        volume|brightness)
            if [ -n "$MODE" ]; then
                echo "Mode already set"
                exit 1
            fi
            MODE="$i"
            shift
        ;;
        --init)
            if lib::exists wob; then
                sh -c "rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob" &
                lib::log "Initialized WOBSOCK at: $WOBSOCK"
            fi
            shift
        ;;
        --mute=*)
            if [[ "$MODE" != volume ]]; then
                # Only works in volume mode
                echo "Mute option only available in volume mode"
                exit 1
            fi
            opt=${i#*=}
            case $opt in
                toggle|yes|no)
                    pactl set-sink-mute @DEFAULT_SINK@ "$opt"
                ;;
                *)
                    echo "Invalid mute option, must be 'toggle', 'yes', or 'no'"
                    exit 1
                ;;
            esac
            if lib::exists wob; then
                # Echo volume to wob
                (
                    [[ $(pactl get-sink-mute @DEFAULT_SINK@ | cut -d' ' -f2) = 'yes' ]] && echo '0' ||
                    pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print substr($5, 1, length($5)-1)}'
                ) > $WOBSOCK
            fi
        ;;
        --*)
            echo "Unknown option $i"
            exit 1
        ;;
        *)
            if [ -n "$VAL" ]; then
                echo "Too many inputs"
                exit 1
            fi
            VAL="$i"
        ;;
  esac
done

# Evaluate input if given
[ -z "$VAL" ] && exit 0
case $MODE in
    volume)
        if ! (echo "$VAL" | grep -E '^[+-][0-9]+%$' >/dev/null); then
            echo "Invalid audio value '$VAL', must be in form '[+-][0-9]+%'"
            exit 1
        fi
        pactl set-sink-mute @DEFAULT_SINK@ 0        # Unmute
        pactl set-sink-volume @DEFAULT_SINK@ "$VAL" # Update volume
        if lib::exists wob; then
            # Notify WOB
            pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 |
                awk '{print substr($5, 1, length($5)-1)}' > $WOBSOCK
        fi
        lib::log "Updated volume: $VAL"
    ;;
    brightness)
        if ( ! echo "$VAL" | grep -E '^\+?[0-9]+%-?$' >/dev/null ); then
            echo "Invalid brightness value '$VAL', must be in form '\+?[0-9]+%-?'"
            exit 1
        fi
        brightness=$(brightnessctl set "$VAL")
        lib::exists wob && echo "$brightness" | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK
        lib::log "Updated brightness: $VAL"
    ;;
    *)
        echo "Missing valid mode"
        exit 1
    ;;
esac
