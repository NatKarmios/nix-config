{ pkgs, config, ... }:
{
  environment.systemPackages = [ pkgs.displaylink ];
  services.xserver.videoDrivers = [
    "modesetting"
    "displaylink"
  ];
}
