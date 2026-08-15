{ inputs, config, ... }:
let
  secretsPath = toString inputs.nix-secrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.sshKeyPaths = [
      "${config.home.homeDirectory}/.ssh/id_ed25519"
    ];

    defaultSopsFile = "${secretsPath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "nix/access_tokens".path = "${config.home.homeDirectory}/.local/secrets/nix_access_tokens";
    };
  };
}
