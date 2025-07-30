{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    obsidian
  ];

  home.activation.symlink-obsidian =
    let
      doc = config.xdg.userDirs.documents;
    in
    ''
      run ln -sfT ~/.local/sync/syncthing/Obsidian ${doc}/Obsidian
      run ln -sfT '${doc}/Obsidian/Notes/99 - Meta/02 - Docs/Papers' ${doc}/papers
      run ln -sfT '${doc}/Obsidian/.zotero' ${doc}/.zotero
    '';

  my.niri.startup-apps.obsidian.cmd = "obsidian";
}
