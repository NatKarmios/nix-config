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
    lib.custom.warnAll
      [
        # Mark band-aid solutions here (or even better, where it is applied)
      ]
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
                nixfmt
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

    hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stuff that multiple other flakes use; including them here to de-duplicate.
    flake-compat.url = "github:NixOS/flake-compat";
    flake-parts.url = "github:hercules-ci/flake-parts";
    crane.url = "github:ipetkov/crane";

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
    };

    # Nix-level configuration for Niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
      inputs.pre-commit.inputs.flake-compat.follows = "flake-compat";
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
      inputs.crane.follows = "crane";
    };

    # Dank Material Shell
    dms = {
      # Tracking master for now because of a Niri update bug; try changing back to stable after a while.
      # https://github.com/AvengeMedia/DankMaterialShell/issues/2525
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };
    # Greeter for Dank Material Shell
    dms-greeter = {
      url = "github:AvengeMedia/dank-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSCode server
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.flake-parts.follows = "flake-parts";
    };

    #
    # ========== Personal Repositories ==========
    #
    # My secrets
    nix-secrets = {
      url = "git+ssh://git@gitlab.com/NatKarmios/nix-secrets.git?ref=main&shallow=1";
    };
  };
}
