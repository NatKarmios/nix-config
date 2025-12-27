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
          system = "x86_64-linux";
        in
        listToAttrs (
          map (host: {
            name = host;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit
                  inputs
                  outputs
                  lib
                  system
                  ;
              };
              modules = [ ./hosts/${host} ];
            };
          }) hosts
        );

      #
      # ========= Dev shell =========
      #
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              stylua
              nixd
              nixfmt-rfc-style
            ];
          };
        }
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
    nixpkgs.follows = "nixpkgs-unstable";

    # Use these to pin to stable / unstable regardless of the "default" set
    # above. Useful for trying a beta stable release so we can set
    # 'nixpkgs-stable' for critical packages while updating 'nixpkgs' to start
    # migrating.
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stuff that multiple other flakes use; including them here to de-duplicate.
    flake-compat.url = "github:edolstra/flake-compat";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    #
    # ========== Utilities ==========
    #
    # Secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Consistent system-wide theming
    stylix = {
      url = "github:nix-community/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };

    # Nix-level configuration for Niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.pre-commit-hooks-nix.inputs.gitignore.follows = "gitignore";
      inputs.flake-parts.follows = "flake-parts";
    };

    # Nicer tmux session management
    tmux-sessionx = {
      url = "github:omerxx/tmux-sessionx";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    # FHS environment for unpatched binaries
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    # Pre-commit
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.gitignore.follows = "gitignore";
    };

    # mkWindowsApp utility
    erosanix = {
      url = "github:emmanuelrosa/erosanix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    # Affinity creative suite
    affinity-nix = {
      url = "github:mrshmllow/affinity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.git-hooks.follows = "git-hooks";
      inputs.flake-parts.follows = "flake-parts";
    };

    # Dank Material Shell
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== Personal Repositories
    #
    # My secrets
    nix-secrets = {
      url = "git+ssh://git@gitlab.com/NatKarmios/nix-secrets.git?ref=main&shallow=1";
    };
  };
}
