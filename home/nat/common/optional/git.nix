{ lib, config, ... }:
{
  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = true;
    };
    userName = lib.mkDefault config.hostSpec.userFullName;
    userEmail = lib.mkDefault config.hostSpec.email;
  };
}

