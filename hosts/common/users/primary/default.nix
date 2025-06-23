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

