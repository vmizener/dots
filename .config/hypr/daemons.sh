# Notification manager
#killall -q mako
#mako &

# Corsair input
killall -u $USER ckb-next
ckb-next -b &

# Clipboard
wl-paste --type text --watch cliphist store &   # Stores only text data
wl-paste --type image --watch cliphist store &  # Stores only image data

# Clear eww lock cache before opening bars
rm ~/.cache/eww-*.lock
~/.config/eww/run eww::popup open topbar
