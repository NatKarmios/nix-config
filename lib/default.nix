{ lib, ... }:
{
  relativeToRoot = lib.path.append ../.;
  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory") # include directories
          || (
            (path != "default.nix") # ignore default.nix
            && (lib.strings.hasSuffix ".nix" path) # include .nix files
          )
        ) (builtins.readDir path)
      )
    );
  prependAttrNames = prefix: attrs: lib.mapAttrs'
    (name: value: lib.nameValuePair (prefix + name) value)
    attrs;
  mod = a: b: a - ((builtins.div a b) * b);
}

