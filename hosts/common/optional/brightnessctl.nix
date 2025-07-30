{ pkgs, config, ... }:
{
  environment.systemPackages = [ pkgs.brightnessctl ];
  users.users.${config.hostSpec.username}.extraGroups = [
    "input"
    "video"
  ];
}
