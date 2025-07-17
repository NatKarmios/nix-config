{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        font_size = 10.0,
      }
    '';
  };
}

