{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  subsituters = [
    {
      url = "https://cache.garnix.io";
      key = "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
    }
    {
      url = "https://niri.cachix.org";
      key = "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=";
    }
  ];
in
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/hosts"
      "hosts/common/core/locale.nix"
      "hosts/common/core/sops.nix"
      "hosts/common/core/ssh.nix"
      "hosts/common/users/primary"
    ])

    #(map lib.custom.relativeToRoot [])
  ];

  #
  # ========== Core host specifications ==========
  #
  hostSpec = with inputs.nix-secrets; {
    username = "nat";
    email = email.business;
    userFullName = fullName;
    handle = handle;
  };

  networking.hostName = config.hostSpec.hostName;
  networking.networkmanager.enable = true;

  console.keyMap = "uk";

  environment.systemPackages = with pkgs; [
    openssh
    git
    vim
    wget
    jq
  ];

  #
  # ========== Overlays ==========
  #
  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config.allowUnfree = true;
  };

  #
  # ========== Nix ==========
  #
  nix = {
    # Adds each flake input as a registry; makes nix3 commands consistent with the flake.
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Adds inputs to the system's legacy channels; makes legacy nix commands consistent too.
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = [ "@wheel" ];
      # Deduplicate and optimise the nix store
      auto-optimise-store = true;
      warn-dirty = false;

      allow-import-from-derivation = true;

      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      substituters = map (s: s.url) subsituters;
      trusted-public-keys = map (s: s.key) subsituters;
    };
  };
}
