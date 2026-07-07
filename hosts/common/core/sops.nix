{
  pkgs,
  inputs,
  config,
  ...
}:
let
  secretsPath = toString inputs.nix-secrets;
in
{
  environment.systemPackages = [ pkgs.sops ];

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
