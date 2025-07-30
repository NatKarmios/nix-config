{ pkgs, ... }:
{
  # I know `services.swayidle` is a thing, but it didn't seem
  #   to work when run this way.
  my.niri.startup-apps.idle.cmd = ''${
    let
      lock = "lock --daemonize";
      display = s: "${pkgs.niri}/bin/niri msg action power-${s}-monitors";
    in
    pkgs.writeShellScript "niri-swayidle" ''
      ${pkgs.swayidle}/bin/swayidle -w \
        timeout 300 '${lock}; ${display "off"}' \
          resume '${display "on"}' \
        timeout 600 '/run/current-system/sw/bin/sleepy' \
        after-resume '${lock}; ${display "on"}'
    ''
  }'';
  #    timeout 300 '${display "off"}' resume '${display "on"}' \
  #    timeout 150 '${pkgs.libnotify}/bin/notify-send "Locking in 30 seconds" -t 5000' \
  #    before-sleep '${display "off"}; ${lock}' \
  #    lock '${display "off"}; ${lock}' \
  #    unlock '${display "on"}'
}
