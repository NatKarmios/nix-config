#
# This file defines overlays/custom modifications to upstream packages
#

{ inputs, ... }:
let

  # Add my custom packages
  additions =
    final: prev:
    let
      erosanix = {
        inherit (inputs.erosanix.lib.${prev.pkgs.system}) mkWindowsApp copyDesktopIcons makeDesktopIcon;
      };
    in
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith (final // erosanix);
      directory = ../pkgs;
    });

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

in
{
  default =
    final: prev:
    { } // (additions final prev) // (stable-packages final prev) // (unstable-packages final prev);
}
