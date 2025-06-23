{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
let
  secretsPath = builtins.toString inputs.nix-secrets;
in
{
  sops = {
    defaultSopsFile = "${secretsPath}/secrets.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    secrets = {
      "passwords/${config.hostSpec.username}".neededForUsers = true;
    };
  };
}

