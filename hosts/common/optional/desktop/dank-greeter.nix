{
  inputs,
  config,
  ...
}:
{
  imports = [ inputs.dms.nixosModules.greeter ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";

    configHome = config.hostSpec.home;

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };
}
