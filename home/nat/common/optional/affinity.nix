{ inputs, system, ... }:
{
  home.packages = [
    inputs.affinity-nix.packages.${system}.v3
  ];
}
