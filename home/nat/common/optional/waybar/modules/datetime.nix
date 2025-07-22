{ ... }:
{
  "group/datetime" = {
    modules = [ "clock#date" "clock#time" ];
    orientation = "horizontal";
  };
  "clock#date" = {
    format = "󰃭  {:%a <b>%b</b> %e}";
    tooltip = false;
  };
  "clock#time" = {
    format = "󰥔  {:%R}";
    tooltip = false;
  };
}

