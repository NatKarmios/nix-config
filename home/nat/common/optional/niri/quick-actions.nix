{
  config,
  pkgs,
  lib,
  ...
}:
let
  escape = lib.escapeShellArg;
  all_opts = builtins.attrValues config.my.niri.quick-actions;
  enabled_opts = builtins.filter (opt: opt.enable) all_opts;
  opts = map (
    opt:
    let
      bind = if opt.bind == null then "" else "  <small><i>(${opt.bind})</i></small>";
      key = escape (opt.desc + bind);
      val = builtins.concatStringsSep " " opt.cmd |> escape;
    in
    "  ${key} ${val}"
  ) enabled_opts;
  opt_binds = builtins.filter (opt: opt.bind != null) enabled_opts;
  binds =
    opt_binds
    |> map (opt: {
      name = opt.bind;
      value.action.spawn = opt.cmd;
    })
    |> builtins.listToAttrs;

  pick-quick-action = pkgs.writeShellScriptBin "niri-quick-action" ''
    wofi-exec \
    ${builtins.concatStringsSep " \\\n" opts}
  '';
in
{
  home.packages = [ pick-quick-action ];

  my.niri.quick-actions = {
    nix-config = {
      desc = "Edit Nix config";
      cmd = [
        "wezterm"
        "start"
        "tmuxinator"
        "start"
        "nix"
      ];
      bind = "Mod+N";
    };
    quick-action = {
      # Meta!
      desc = "Quick action";
      cmd = [ "niri-quick-action" ];
      bind = "Mod+A";
    };
  };

  programs.niri.settings.binds = binds;
}
