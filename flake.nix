{
  description = "Nat's Nix config";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      #
      # ========= Architectures =========
      #
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        #"aarch64-darwin"
      ];

      # ===== Extend lib with lib.custom
      # This approach allows lib.custom to propagate into hm
      # see: https://github.com/nix-community/home-manager/pull/3454
      lib =
        let
          custom = import ./lib { inherit (nixpkgs) lib; };
        in
        nixpkgs.lib.extend (self: super: { inherit custom; });

    in
    {
      #
      # ========== Overlays ==========
      #
      # Custom modifications/overrides to upstream packages
      overlays = import ./overlays { inherit inputs; };

      #
      # ========== Host Configurations ==========
      #
      nixosConfigurations =
        with builtins;
        let
          hosts = lib.remove "common" (attrNames (readDir ./hosts));
        in
        listToAttrs (
          map (host: {
            name = host;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs outputs lib;
              };
              modules = [ ./hosts/${host} ];
            };
          }) hosts
        );

      #
      # ========= Formatting =========
      #
      # Nix formatter available through 'nix fmt' https://github.com/NixOS/nixfmt
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      # Pre-commit checks
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./checks.nix { inherit inputs system pkgs; }
      );
    };

  inputs = {
    #
    # ========== Official sources ==========
    #
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Use these to pin to stable / unstable regardless of the "default" set
    # above. Useful for trying a beta stable release so we can set
    # 'nixpkgs-stable' for critical packages while updating 'nixpkgs' to start
    # migrating.
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== Utilities ==========
    #
    # Secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-level configuration
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Consistent system-wide theming
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
    };

    # Nix-level configuration for Niri
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nicer tmux session management
    tmux-sessionx = {
      url = "github:omerxx/tmux-sessionx";
    };

    # Dynamic wallpapers
    timewall = {
      url = "github:bcyran/timewall";
    };

    # Pre-commit
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== Personal Repositories
    #
    # My secrets
    nix-secrets = {
      url = "git+ssh://git@gitlab.com/NatKarmios/nix-secrets.git?ref=main&shallow=1";
      inputs = { };
    };
  };
}
