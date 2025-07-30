#
# Peer to peer folder sync
#

{
  lib,
  config,
  inputs,
  ...
}:
with (with config.hostSpec; {
  inherit username hostName;
});
let
  sync-path = "/home/${username}/.local/sync/syncthing";

  deviceIds = inputs.nix-secrets.syncthing.deviceIds;
  secrets = config.sops.secrets;

  mkDeviceAttr =
    device:
    let
      id = builtins.getAttr device.name deviceIds;
    in
    {
      name = device.name;
      value = device // {
        inherit id;
      };
    };

  keyAttr = "syncthing/${hostName}/key";
  certAttr = "syncthing/${hostName}/cert";
in
{
  sops.secrets = {
    "${keyAttr}".owner = username;
    "${certAttr}".owner = username;
  };

  services.syncthing = {
    enable = true;
    user = username;
    configDir = "/home/${username}/.config/syncthing";
    openDefaultPorts = true;
    dataDir = sync-path;

    key = secrets."${keyAttr}".path;
    cert = secrets."${certAttr}".path;

    settings = {
      devices = lib.listToAttrs (
        map mkDeviceAttr [
          {
            name = "Surfux";
            autoAcceptFolders = true;
          }
          {
            name = "Magic";
            autoAcceptFolders = true;
          }
          {
            name = "Franken";
            autoAcceptFolders = true;
          }
        ]
      );

      folders = {
        "Obsidian" = {
          id = "qh47e-tfmhu";
          path = "${sync-path}/Obsidian";
          devices = [
            "Surfux"
            "Magic"
            "Franken"
          ];
        };
      };
    };
  };

  # Don't create default ~/Sync folder
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
