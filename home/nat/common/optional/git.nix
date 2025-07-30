{
  lib,
  pkgs,
  config,
  ...
}:
let
  # https://www.reddit.com/r/git/comments/1coropv/comment/l3mwfso/
  git-ssh-sign = pkgs.writeShellScript "git-ssh-sign" ''
    #!/bin/sh
    while getopts Y:n:f: opt; do case $opt in 
    f) ssh-add -T "$OPTARG" 2>&- || ssh-add "$OPTARG" ;;
    esac; done

    exec ssh-keygen "$@"
  '';
in
{
  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = true;
      signer = "${git-ssh-sign}";
    };
    userName = lib.mkDefault config.hostSpec.userFullName;
    userEmail = lib.mkDefault config.hostSpec.email;
  };
}
