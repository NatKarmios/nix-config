{ inputs, config, ... }:
with (with config.hostSpec; { inherit hostName; });
let
  secrets-path = builtins.toString inputs.nix-secrets;
  private = import "${secrets-path}/private.nix";
  ztPath = "/var/lib/zerotier-one";

  publicAttr = "zerotier/${hostName}/public";
  secretAttr = "zerotier/${hostName}/secret";
in
{
  services.zerotierone = {
    enable = true;
    joinNetworks = private.zerotier.networkIds;
  };

  sops.secrets = {
    "${publicAttr}".path = "${ztPath}/identity.public";
    "${secretAttr}".path = "${ztPath}/identity.secret";
  };
}

