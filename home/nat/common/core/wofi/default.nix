#
# Quick, versatile GUI menus
#

{ pkgs, ... }:
let
  wofi-app = pkgs.writeShellScriptBin "wofi-app" ''
    wofi --allow-images --columns=4 --show drun -a
  '';
  wofi-exec = pkgs.writeShellScriptBin "wofi-exec" ''
    pairs=("$@")
    declare -A options

    for (( i=0; i<''${#pairs[@]}; i+=2 )); do
      options["''${pairs[$i]}"]="''${pairs[$((i+1))]}"
    done

    key=$(printf "%s\n" "''${!options[@]}" | wofi -m --dmenu)
    exec bash -c "''${options[$key]}"
  '';
in
{
  programs.wofi = {
    enable = true;
    style = builtins.readFile ./style.css;
  };

  stylix.targets.wofi.enable = false;

  home.packages = [
    wofi-app
    wofi-exec
  ];
}

