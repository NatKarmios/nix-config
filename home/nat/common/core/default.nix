{
  config,
  inputs,
  lib,
  pkgs,
  hostSpec,
  system,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/home"
    ])

    ./nvim.nix
    ./tmux
    ./wezterm.nix
    ./wofi
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  inherit hostSpec;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "24.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "${config.home.homeDirectory}/src/nix/nix-config";
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

    # Allow unfree packages in shell commands
    configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";
  };

  home.packages =
    # Packages that don't have custom configs go here
    (
      with pkgs;
      [
        bat # better cat/less
        bat-extras.core
        bottom # system monitor
        copyq # clipboard manager
        curl
        eza # ls replacement
        dust # disk usage
        fd # tree-style ls
        findutils # find
        fzf # fuzzy find
        jq # json pretty-printer and manipulator
        gum # a bunch of helpful utilities for shell scripting
        manix # Nix options search
        nix-tree # nix package tree viewer
        neofetch # fancier system info than pfetch
        ncdu # TUI disk usage
        p7zip # compression & encryption
        pciutils
        procs # better ps
        ripgrep # better grep
        sd # simpler cut / awk
        systemctl-tui
        usbutils
        uutils-coreutils-noprefix # Rust rewrite of basic GNU utils
        tree # cli dir tree viewer
        unzip # zip extraction
        unrar # rar extraction
        wev # show wayland events, also handy for detecting keypress codes
        wget # downloader
        xdg-utils # provide cli tools such as `xdg-mine` and `xdg-open`
        xdg-user-dirs
        yq-go # yaml pretty printer and manipulator
        zip # zip compression

        inputs.nix-alien.packages.${system}.default
      ]
    );

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      # These values are from the default config;
      # the default is going away at some point, and currently raises a warning.
      forwardAgent = false;
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
    enableDefaultConfig = false;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
