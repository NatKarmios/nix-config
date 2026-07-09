{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.displaylink ];
  services.xserver.videoDrivers = [
    "modesetting"
    "displaylink"
  ];
  systemd.services.dlm = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      TimeoutStopSec = 10;
    };
  };
}
