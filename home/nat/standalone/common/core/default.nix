{ inputs, ... }:
{
  imports = [
    ../../../common/core
  ];

  hostSpec = with inputs.nix-secrets; {
    username = "nat";
    email = email.business;
    userFullName = fullName;
    handle = handle;
  };
}
