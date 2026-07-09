{ pkgs, config, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ config.hostSpec.username ];
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "no";
    };
  };

  # Intrusion prevention
  services.fail2ban.enable = true;

  # Wayland equivalent of ssh -X
  environment.systemPackages = [ pkgs.waypipe ];
}
