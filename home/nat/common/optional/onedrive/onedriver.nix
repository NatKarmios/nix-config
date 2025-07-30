#
# OneDrive as a network drive
#

{ pkgs, ... }:
let
  onedrive-remote-dir = "~/.local/sync/onedrive-remote";
in
{
  # Onedriver complains if the config doesn't exist
  # https://github.com/jstaf/onedriver/blob/master/pkg/resources/config-example.yml
  xdg.configFile."onedriver/config.yml".text = ''
    log: info
    cacheDir: ~/.cache/onedriver
  '';

  home.packages = [ pkgs.onedriver ];

  home.activation.mk-onedrive-remote-dir = ''
    run mkdir -p ${onedrive-remote-dir}
  '';

  systemd.user.services.onedriver = {
    Unit.Description = "A native Linux filesystem for Microsoft OneDrive";
    Install.WantedBy = [ "default.target" ];

    # Use `sh` so we can expand `~`
    Service.ExecStart =
      let
        bin = "${pkgs.onedriver}/bin/onedriver";
      in
      ''/usr/bin/env sh -c "${bin} ${onedrive-remote-dir} -n"'';
  };
}
