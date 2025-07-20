{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        font_size = 10.0,
        hide_tab_bar_if_only_one_tab = true,
      }
    '';
  };
}

