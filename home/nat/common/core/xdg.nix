{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      xdg-utils # provide cli tools such as `xdg-mine` and `xdg-open`
      xdg-user-dirs
    ];
    preferXdgDirectories = true;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
      desktop = "${config.home.homeDirectory}/.desktop";
      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/media/audio";
      pictures = "${config.home.homeDirectory}/media/images";
      videos = "${config.home.homeDirectory}/media/video";
      projects = "${config.home.homeDirectory}/projects";

      extraConfig = {
        PUBLICSHARE = "/var/empty";
        TEMPLATES = "/var/empty";
      };
    };
  };
}
