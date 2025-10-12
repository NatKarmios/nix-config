#
# OneDrive as a network drive
#

{ pkgs, config, ... }:
let
  onedrive-remote-dir = "${config.home.homeDirectory}/.local/sync/onedrive-remote";
in
{
  # Onedriver complains if the config doesn't exist
  # https://github.com/jstaf/onedriver/blob/master/pkg/resources/config-example.yml
  xdg.configFile."onedriver/config.yml".text = ''
    log: info
    cacheDir: ${config.xdg.cacheHome}/onedriver
  '';

  home.packages = [ pkgs.onedriver ];

  home.activation.mk-onedrive-remote-dir = ''
    run mkdir -p ${onedrive-remote-dir}
  '';

  systemd.user.services.onedriver = {
    Unit.Description = "A native Linux filesystem for Microsoft OneDrive";
    Install.WantedBy = [ "default.target" ];

    # Use a shell script so we can expand `~`
    Service.ExecStart =
      let my-onedriver =
        pkgs.writeShellApplication {
          name = "my-onedriver";
          runtimeInputs = [ pkgs.fuse3 ];
          text = ''
            exec ${pkgs.onedriver}/bin/onedriver ${onedrive-remote-dir} -n
          '';
        };
      in
      "${my-onedriver}/bin/my-onedriver";
  };
}
