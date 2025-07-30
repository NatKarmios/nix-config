{ lib, ... }:
with (lib.types);
with (with lib; {
  inherit mkOption;
});
{
  options.my.niri = {
    startup-apps = mkOption {
      default = { };
      description = "Apps to start up automatically with Niri";
      type = attrsOf (submodule {
        options = {
          enable = mkOption {
            type = bool;
            default = true;
          };
          cmd = mkOption {
            type = oneOf [
              (nonEmptyListOf str)
              str
            ];
            apply = c: if (lib.isString c) then [ c ] else c;
          };
        };
      });
    };

    quick-actions = mkOption {
      default = { };
      description = ''Things to show in the "quick actions" picker'';
      type = attrsOf (submodule {
        options = {
          enable = mkOption {
            type = bool;
            default = true;
          };
          desc = mkOption {
            type = string;
          };
          cmd = mkOption {
            type = nonEmptyListOf string;
          };
          bind = mkOption {
            type = nullOr string;
            default = null;
          };
        };
      });
    };
  };
}
