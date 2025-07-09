{ 
  config,
  lib,
  pkgs,
  ... 
}:
{
  imports = [
    ./nixvim
    ./rofi.nix
    ./wezterm.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "24.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/nix-config";
      SHELL = "zsh";
      TERMINAL = "wezterm";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
    preferXdgDirectories = true;
  };


  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/.desktop";
      documents = "${config.home.homeDirectory}/doc";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/media/audio";
      pictures = "${config.home.homeDirectory}/media/images";
      videos = "${config.home.homeDirectory}/media/video";

      ## "using these options with null or "/var/empty" barfs so it is set properly in extraConfig below"
      # publicshare = "/var/empty";
      # templates = "/var/empty";

      extraConfig = {
        XDG_PUBLICSHARE_DIR = "/var/empty";
        XDG_TEMPLATES_DIR = "/var/empty";
      };
    };
  };

  home.packages = 
    # Packages that don't have custom configs go here
    (with pkgs; [
      copyq  # clipboard manager
      uutils-coreutils-noprefix  # Rust rewrite of basic GNU utils
      curl
      eza  # ls replacement
      dust  # disk usage
      fd  # tree-style ls
      findutils  # find
      fzf  # fuzzy find
      jq  # json pretty-printer and manipulator
      lazygit  # terminal git porcelain
      nix-tree  # nix package tree viewer
      neofetch  # fancier system info than pfetch
      ncdu  # TUI disk usage
      pciutils
      p7zip  # compression & encryption
      ripgrep  # better grep
      usbutils
      tree  # cli dir tree viewer
      unzip  # zip extraction
      unrar  # rar extraction
      wev  # show wayland events, also handy for detecting keypress codes
      wget  # downloader
      xdg-utils  # provide cli tools such as `xdg-mine` and `xdg-open`
      xdg-user-dirs
      yq-go  # yaml pretty printer and manipulator
      zip  # zip compression
    ]);

    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
      };
    };

    programs.home-manager.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
}

