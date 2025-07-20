{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    obsidian
  ];

  home.activation.symlink-obsidian = ''
    run ln -sfT ~/.local/sync/syncthing/Obsidian ${config.xdg.userDirs.documents}/Obsidian
  '';
}

