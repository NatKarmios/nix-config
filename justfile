default:
  @just --list

rebuild host=shell("hostname"):
  nixos-rebuild switch --flake "{{justfile_directory()}}#{{host}}" --use-remote-sudo
