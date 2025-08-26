{ pkgs, config, ... }:
{
  environment.systemPackages = [ pkgs.displaylink ];
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.evdi ];
    initrd.kernelModules = [ "evdi" ];
  };
}

