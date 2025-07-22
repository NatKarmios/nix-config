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
  nixvim = rec {
    raw = s: { __raw = s; };
    call = p: s: raw "function() require('${p}').${s} end";

    # Quick bind functions
    bind-helpers = rec {
      bind'' = mode: key: action: options: {
        inherit mode key action options;
      };
      bind' = mode: key: action: desc: bind'' mode key action { inherit desc; };
      bind = mode: key: action: bind'' mode key action {};

      n = bind "n";
      n' = bind' "n";
      i = bind "i";
      t' = bind' "t";
      nv = bind ["n" "v"];
      nv' = bind' ["n" "v"];
      nx' = bind' ["n" "x"];
      nox = bind ["n" "o" "x"];

      cmd = s: "<cmd>${s}<CR>";
    };

    toAttrKeymap = bs:
      let attrs = map ({ key, ... }@b:
        let value = lib.removeAttrs b [ "key" ]; in
        { name = key; inherit value; })
        (lib.flatten bs);
      in
      lib.listToAttrs attrs;

    # Bind transformers
    mapBinds = f: bs: map f (lib.flatten bs);
    prependKey = p: mapBinds (b: b // { key = p + b.key; });
    prependRawAction = p: mapBinds (b: b // { action = (raw (p + b.action)); });
  };
}

