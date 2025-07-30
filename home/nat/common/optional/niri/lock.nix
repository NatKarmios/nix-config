{
  pkgs,
  ...
}:
let
  lock-script = pkgs.writeShellScriptBin "lock" ''
    exec swaylock --screenshots --clock --indicator --font "Source Sans Pro" \
      --font-size "64px" --key-hl-color "#cba6f7" --effect-blur 8x8 "$@"
  '';
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

  home.packages = [ lock-script ];
}
