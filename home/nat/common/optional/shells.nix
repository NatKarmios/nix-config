{ pkgs, lib, ... }:
let
  quick-nix-shell = pkgs.writeShellScriptBin "ns" ''
    nix-shell -p $@ --run "zsh"
  '';
  shell-template = ''
    { pkgs ? import <nixpkgs> {} }:

    pkgs.mkShell {
      packages = with pkgs; [  ];
    }
  '';
  mkshell = pkgs.writeShellScriptBin "mkshell" ''
    DIR="''${1:-.}"
    mkdir -p $DIR
    echo "use nix" > "$DIR/.envrc"
    echo ${lib.escapeShellArg shell-template} > "$DIR/shell.nix"
    $EDITOR $DIR/shell.nix
  '';
in
{
  home.packages = [
    quick-nix-shell
    mkshell
  ];
}
