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
  opt_assigns = map (
    opt:
    let
      bind = if opt.bind == null then "" else "  <small><i>(${opt.bind})</i></small>";
      key = escape (opt.desc + bind);
      val = builtins.concatStringsSep " " (map escape opt.cmd);
    in
    ''actions[${key}]="${val}"''
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
    declare -A actions
    ${builtins.concatStringsSep "\n" opt_assigns}

    key=$(printf "%s\n" "''${!actions[@]}" | wofi -m --dmenu)
    exec bash -c "''${actions[$key]}"
  '';
in
{
  home.packages = [ pick-quick-action ];

  my.niri.quick-actions = {
    email = {
      desc = "Edit Nix config";
      cmd = [
        "wezterm"
        "start"
        "tmux"
        "new-session"
        "ZSH_RUN='cd $FLAKE; $EDITOR' zsh"
      ];
      bind = "Mod+M";
    };
    quick-action = {
      # Meta!
      desc = "Quick action";
      cmd = [ "${pick-quick-action}/bin/niri-quick-action" ];
      bind = "Mod+A";
    };
  };

  programs.niri.settings.binds = binds;
}
