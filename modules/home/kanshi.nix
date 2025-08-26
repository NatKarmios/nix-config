{ lib, ... }:
with (lib.types);
with (with lib; {
  inherit mkOption mapAttrsToList;
});
{
  options.my.kanshi = {
    outputs = mkOption {
      type = attrsOf (attrsOf anything);
      default = {};
      apply = mapAttrsToList (alias: attrs: {
        output = attrs // { inherit alias; };
      });
    };

    profiles = mkOption {
      type = listOf (attrsOf anything);
      default = [];
      apply = map (attrs: { profile = attrs; });
    };

    other-settings = mkOption {
      type = listOf (attrsOf anything);
      default = [];
    };
  };
}
