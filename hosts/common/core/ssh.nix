{
  pkgs,
  config,
  lib,
  ...
}:
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

  programs.ssh.startAgent = lib.mkDefault true;

  # Make sure SSH agent works on SSH logins
  environment.interactiveShellInit = ''
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"  # or $XDG_RUNTIME_DIR/ssh-agent
  '';
}
