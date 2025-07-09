# Specifications for differentiating hosts
{
  config,
  lib,
  ...
}:
{
  options.hostSpec = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Username of the host's primary user";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Host's hostname";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Email address of the host's primary user";
    };
    domain = lib.mkOption {
      type = lib.types.str;
      description = "Host's domain";
    };
    userFullName = lib.mkOption {
      type = lib.types.str;
      description = "Full name of the host's primary user";
    };
    handle = lib.mkOption {
      type = lib.types.str;
      description = "User's handle (e.g. GitHub username)";
    };
    home = lib.mkOption {
      type = lib.types.str;
      description = "Home directory of the primary user";
      default = "/home/${config.hostSpec.username}";
    };
  };
}

