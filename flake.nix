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
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs lib;
            };
            modules = [ ./hosts/nixos/${host} ];
          };
        }) (builtins.attrNames (builtins.readDir ./hosts/nixos))
      );


      #nixosConfigurations.nat-surface = pkgs.lib.nixosSystem {
      #  system = "x86_64-linux";
      #  modules = [
      #    # Import the previous configuration.nix we used,
      #    # so the old configuration file still takes effect
      #    ./configuration.nix
      #    nixos-hardware.nixosModules.microsoft-surface-common
      #    sops-nix.nixosModules.sops
      #  ];
      #};
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

    #
    # ========== Utilities ==========
    #
    # Secrets management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@gitlab.com/NatKarmios/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };
  };
}
