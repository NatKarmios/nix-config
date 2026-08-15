{ lib, config, ... }: {
  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.share = true;


    shellAliases = {
      q = "exit";
    };

    initContent = lib.mkOrder 999999 ''
      if [[ -n $ZSH_RUN ]] then
        eval $ZSH_RUN
      fi
      unset ZSH_RUN
    '';
  };

  home.sessionVariables.SHELL = "zsh";
}
