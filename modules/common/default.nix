# https://wiki.nixos.org/wiki/NixOS_modules

{ lib, ... }:
{
  imports = lib.custom.scanPaths ./.;
}

