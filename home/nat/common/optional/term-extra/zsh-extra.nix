{ config, ... }: {
  programs.zsh = {
    shellAliases = {
      doc = "cd ${config.xdg.userDirs.documents}";
      src = "cd ~/src";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo" # press Esc twice to get the previous command prefixed with sudo
      ];
      extraConfig = ''
        # Display red dots whilst waiting for completion.
        COMPLETION_WAITING_DOTS="true"
      '';
    };
  };

  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
