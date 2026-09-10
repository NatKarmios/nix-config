set dotenv-load
set export

mode := env_var_or_default("REBUILD_MODE", "nixos")
target := env_var_or_default("REBUILD_TARGET", "")

default:
  @just --list

rebuild-nixos host=shell("hostname"):
  nixos-rebuild switch --flake "{{justfile_directory()}}#{{host}}" --sudo

rebuild-home-manager user=shell("whoami"):
  home-manager switch --flake "{{justfile_directory()}}#{{user}}"

rebuild:
  just rebuild-{{mode}} {{target}}
