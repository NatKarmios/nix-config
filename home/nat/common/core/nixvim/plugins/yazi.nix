#
# File manager
#

{
  programs.nixvim = {
    plugins.yazi = {
      enable = true;
      settings.open_for_directories = true;  # Use Yazi when "opening" direcories in nvim
    };
  };
}

