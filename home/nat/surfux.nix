{ ... }:
{
  imports = [
    common/core
    common/optional/niri

  home.packages = with pkgs; [
    obsidian
  ];
}

