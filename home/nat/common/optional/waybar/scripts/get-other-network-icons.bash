connections="$(nmcli -t connection show --active)"

if [[ -n "$(echo "$connections" | grep '[^\]:bluetooth:')" ]] then
  pre=1
  echo -n "󰂰"
fi

if [[ -n "$(echo "$connections" | grep '[^\]:ethernet:')" ]] then
  pre=1
  echo -n "󰈀"
fi

echo

