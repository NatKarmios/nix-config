{
  pkgs,
  inputs,
  system,
  ...
}:
{

  programs.claude-code.enable = true;

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
