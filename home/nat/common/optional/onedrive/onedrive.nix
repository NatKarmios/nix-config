#
# Bi-directional OneDrive sync for select folders
#

{ pkgs, config, ... }:
let
  onedrive-dir = "~/.local/sync/onedrive";
  onedrive-pkg = pkgs.onedrive;
  inherit (config.xdg) userDirs;
in
{
  programs.onedrive = {
    enable = true;
    package = onedrive-pkg;
    settings = {
      sync_dir = onedrive-dir;
    };
  };

  # https://github.com/abraunegg/onedrive/blob/master/docs/usage.md#performing-a-selective-synchronisation-via-sync_list-file
  xdg.configFile."onedrive/sync_list".text = ''
    # Don't need org
    !/Documents/org

    # Papers should be synced via Syncthing
    !/Documents/Papers

    # "Standard" dirs
    /Documents
    /Pictures
    /Music
    /Videos
    /Scripts
  '';

  home.activation.mk-onedrive-dir-and-symlink = ''
    run mkdir -p ${onedrive-dir}
    run ln -sfT ${onedrive-dir}/Documents ${userDirs.documents}/onedrive
    run ln -sfT ${onedrive-dir}/Pictures ${userDirs.pictures}/onedrive
    run ln -sfT ${onedrive-dir}/Music ${userDirs.music}/onedrive
    run ln -sfT ${onedrive-dir}/Videos ${userDirs.videos}/onedrive
    run ln -sfT ${onedrive-dir}/Pictures/Screenshots ${userDirs.pictures}/screenshots
  '';

  systemd.user.services.onedrive = {
    Unit.Description = "OneDrive Client for Linux";
    Install.WantedBy = [ "default.target" ];
    Service.ExecStart = "${onedrive-pkg}/bin/onedrive -m";
  };
}
