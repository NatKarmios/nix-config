{ pkgs, config, ... }:
let
  jq-scale-query = "1.0 / (.logical.scale | if . then . else 1.0 end)";
  jq-query = ''map("\(.name)=\(${jq-scale-query})") | join(";")'';
  fshot = pkgs.writeShellScriptBin "fshot" ''
    factors="$(niri msg -j outputs | jq -r '${jq-query}')"
    QT_SCREEN_SCALE_FACTORS="$factors" flameshot $@
  '';
  sshot = pkgs.writeShellScriptBin "sshot" ''
    dir="${config.xdg.userDirs.pictures}/screenshots/$(date +%Y-%m)"
    file="$(date +%Y-%m-%d_%H-%M-%S).png"
    mkdir -p $dir
    fshot gui -p "$dir/$file" -c $@
    ${pkgs.swayimg}/bin/swayimg "$dir/$file" --size=300,190 & disown
  '';
in
{
  home.packages = [
    fshot
    sshot
  ];

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override { enableWlrSupport = true; };
    settings = {
      "General" = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };

  programs.niri.settings.window-rules = [{
    matches = [{ app-id = "swayimg"; }];
    open-floating = true;
    baba-is-float = true;
    default-floating-position = {
      x = 10;
      y = 30;
      relative-to = "top-right";
    };
  }];

  my.niri.quick-actions.screenshot = {
    desc = "Take a screenshot";
    cmd = ["sshot"];
    bind = "Mod+S";
  };
}

