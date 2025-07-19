#
# Self-hosted WAN
#

{ inputs, config, ... }:
with (with config.hostSpec; { inherit hostName; });
let
  ztPath = "/var/lib/zerotier-one";

  publicAttr = "zerotier/${hostName}/public";
  secretAttr = "zerotier/${hostName}/secret";
in
{
  services.zerotierone = {
    enable = true;
    joinNetworks = inputs.nix-secrets.zerotier.networkIds;
  };

  sops.secrets = {
    "${publicAttr}".path = "${ztPath}/identity.public";
    "${secretAttr}".path = "${ztPath}/identity.secret";
  };
}

