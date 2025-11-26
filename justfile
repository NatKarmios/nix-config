default:
  @just --list

rebuild host=shell("hostname"):
  nixos-rebuild switch --flake "{{justfile_directory()}}#{{host}}" --sudo
