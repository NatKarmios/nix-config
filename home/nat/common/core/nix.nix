{ lib, pkgs, config, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      warn-dirty = false;
    };
    extraOptions = lib.mkIf
      (lib.hasAttrByPath [ "sops" "secrets" "nix/access_tokens" ] config)
      ''
        !include ${config.sops.secrets."nix/access_tokens".path}
      '';
  };

  nixpkgs.config.allowUnfree = true;
}
