{
  inputs,
  config,
  ...
}:
{
  imports = [ inputs.dms-greeter.nixosModules.default ];

  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";

    configHome = config.hostSpec.home;

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };
}
