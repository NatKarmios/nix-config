{
  description = "Nat's Nix config";

  outputs = {
    self,
    nixpkgs,
    ...
  }@inputs:
    let
      inherit (self) outputs;

      # ===== Extend lib with lib.custom
      # This approach allows lib.custom to propagate into hm
      # see: https://github.com/nix-community/home-manager/pull/3454
      lib =
        let custom = import ./lib { inherit (nixpkgs) lib; }; in 
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
        let hosts = lib.remove "common" (attrNames (readDir ./hosts)); in
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

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    # ========== Personal Repositories
    #
    # My secrets
    nix-secrets = {
      url = "git+ssh://git@gitlab.com/NatKarmios/nix-secrets.git?ref=main&shallow=1";
      inputs = {};
    };
  };
}
