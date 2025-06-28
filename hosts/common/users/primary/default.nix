{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  hostSpec = config.hostSpec;

  # Decrypt password to /run/secrets-for-users/ so it can be used to create the user
  sopsHashedPasswordFile = config.sops.secrets."passwords/nat".path;
in
{
  users = {
    users.${hostSpec.username} = {
      name = hostSpec.username;
      home = "/home/${hostSpec.username}";
      isNormalUser = true;
      hashedPasswordFile = sopsHashedPasswordFile;
      shell = pkgs.zsh;  # default shell
      extraGroups = [ "wheel" ];
    };
  };

  programs.zsh.enable = true;
}
# Import home config if relevant
// lib.optionalAttrs (inputs ? "home-manager") {
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit pkgs inputs;
      hostSpec = config.hostSpec;
    };
    users.${hostSpec.username}.imports = lib.flatten ([
      (
        { config, ... }:
        import (lib.custom.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}.nix") {
          inherit
            pkgs
            inputs
            config
            lib
            hostSpec
            ;
        }
      )
    ]);
  };
}

