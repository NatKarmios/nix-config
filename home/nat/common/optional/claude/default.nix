{ pkgs, config, ... }:
{

  programs.claude-code = {
    enable = true;
    configDir = "${config.xdg.configHome}/claude";
  };

  home.packages =
    let
      ccsend = pkgs.writeShellScriptBin "ccsend" (builtins.readFile ./ccsend.sh);
    in
    [ ccsend ];
}
