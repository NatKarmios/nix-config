{ config, ... }:
let
  npm-dir = "${config.xdg.dataHome}/npm";
in
{
  programs.npm = {
    enable = true;
    settings.prefix = npm-dir;
  };

  home.sessionPath = [
    "${npm-dir}/bin"
  ];
}
