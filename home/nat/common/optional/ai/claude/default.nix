{
  pkgs,
  config,
  inputs,
  system,
  ...
}:
{

  programs.claude-code = {
    enable = true;
    configDir = "${config.xdg.configHome}/claude";
  };

  home.packages =
    let
      ccsend = pkgs.writeShellScriptBin "ccsend" (builtins.readFile ./ccsend.sh);
      claude-desktop = inputs.claude-desktop.packages.${system}.default;
    in
    [
      ccsend
      claude-desktop
      pkgs.claude-swap
    ];
}
