{ pkgs, lib, ... }:
let
  devDirectory = "~/src";
  devNix = "${devDirectory}/nix";
in
{
  home.packages = with pkgs; [
    just
    thefuck
    tldr
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";  # relative to '~'
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.share = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"  # press Esc twice to get the previous command prefixed with sudo
      ];
      extraConfig = ''
        # Display red dots whilst waiting for completion.
        COMPLETION_WAITING_DOTS="true"
      '';
    };

    shellAliases = {
      q = "exit";
      lg = "lazygit";
      tx = "tmux attach || tmux";

      #----------Navigation----------
      doc = "cd $HOME/docs";
      src = "cd $HOME/src";
      l = "eza -lah";
      la = "eza -lah";
      ll = "eza -lh";
      ls = "eza";
      lsa = "eza -lah";

      #----------Nix src navigation----------
      cnc = "cd ${devNix}/nix-config";
      cns = "cd ${devNix}/nix-secrets";
      cnp = "cd ${devNix}/nixpkgs";

      #----------Nix commands----------
      nfc = "nix flake check";
      ne = "nix instantiate --eval";
      nb = "nix build";
      ns = "nix shell";

      #----------justfile----------
      jr = "just rebuild";
      jrt = "just rebuild-trace";
      jl = "just --list";
      jc = "$just check";
      jct = "$just check-trace";

      #----------Neovim----------
      e = "nvim";
      vi = "nvim";
      vim = "nvim";
    };

    initContent = lib.mkOrder 999999 ''
      if [[ -n $ZSH_RUN ]] then
        eval $ZSH_RUN
      fi
      unset ZSH_RUN
    '';
  };
}

