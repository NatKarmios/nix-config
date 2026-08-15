{ pkgs, config, lib, inputs, system, ... }:
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
  devDirectory = "${config.home.homeDirectory}/src";
  devNix = "${devDirectory}/nix";
in
{
  home = {
    packages = with pkgs; [
      manix # Nix options search
      nix-tree # nix package tree viewer
      just
    ] ++ [
      inputs.nix-alien.packages.${system}.default
      quick-nix-shell
      mkshell
    ];
    sessionVariables.FLAKE = "${devNix}/nix-config";
  };

  programs.zsh = {
    shellAliases = {
      #----------Nix src navigation----------
      cnc = "cd ${devNix}/nix-config";
      cns = "cd ${devNix}/nix-secrets";
      cnp = "cd ${devNix}/nixpkgs";

      #----------Nix commands----------
      nfc = "nix flake check";
      ne = "nix instantiate --eval";
      nb = "nix build";

      #----------justfile----------
      jr = "just rebuild";
      jrt = "just rebuild-trace";
      jl = "just --list";
      jc = "$just check";
      jct = "$just check-trace";
    };

    initContent = ''
        function nr() {
          nix run "nixpkgs#$1" -- ''${@:2}
        }
    '';
  };
}
