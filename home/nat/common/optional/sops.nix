{ inputs, config, ... }:
let
  secretsPath = toString inputs.nix-secrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${secretsPath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "nix/access_tokens".path = "${config.home.homeDirectory}/.local/secrets/nix_access_tokens";
    };
  };
}
