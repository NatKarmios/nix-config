#
# This file defines overlays/custom modifications to upstream packages
#

{ inputs, ... }:
let
  # Add my custom packages
  additions = {
    nixpkgs =
      final: prev:
      let
        erosanix-pkgs = inputs.erosanix.lib.${prev.pkgs.stdenv.hostPlatform.system};
        erosanix = {
          inherit (erosanix-pkgs) mkWindowsApp copyDesktopIcons makeDesktopIcon;
        };
      in
      (prev.lib.packagesFromDirectoryRecursive {
        callPackage = prev.lib.callPackageWith (final // erosanix);
        directory = ../pkgs/nixpkgs;
      });

    # Python additions
    python3 = _final: prev: {
      python3 = prev.python3.override {
        packageOverrides = pyfinal: pyprev:
          (prev.lib.packagesFromDirectoryRecursive {
            callPackage = pyprev.callPackage;
            directory = ../pkgs/python3;
          });
       };
    };
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };

in
{
  default =
    final: prev:
    { } //
      (additions.nixpkgs final prev) //
      (additions.python3 final prev) //
      (stable-packages final prev) //
      (unstable-packages final prev) //
      (inputs.niri.overlays.niri final prev) //
      (inputs.affinity-nix.overlays.default final prev);
}
