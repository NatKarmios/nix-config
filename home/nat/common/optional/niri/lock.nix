{
  pkgs,
  ...
}:
let
  lock-script = pkgs.writeShellScriptBin "lock" ''
    exec swaylock --screenshots --clock --indicator \
      --effect-blur 8x8 "$@"
  '';
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

  home.packages = [ lock-script ];
}

