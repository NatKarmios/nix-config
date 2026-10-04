{
  services.gnome.gnome-keyring.enable = true;

  # Enable auto-unlock for the relevant PAM services:
  security.pam.services.login.enableGnomeKeyring = true; # TTY login
  security.pam.services.sshd.enableGnomeKeyring = true; # SSH logins
}
