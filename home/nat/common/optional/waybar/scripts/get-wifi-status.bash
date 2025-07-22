devices="$(nmcli -t device)"
wifi_devices="$(echo "$devices" | grep '[^\]:wifi:')"
ssid="$(echo "$wifi_devices" | sed -nr 's/^.+[^\]:connected:(.+)$/\1/mp' | head -n 1)"

if [[ -n "$ssid" ]] then
  echo "󰖩 $ssid"
elif [[ -n "$(echo "$wifi_devices" | grep '[^\]:disconnected:')" ]] then
  echo "󱛅"
else
  echo "󰖪"
fi

