{
  imports = [
    ../common/core

    ../../common/optional/ai
    ../../common/optional/dev/core
    ../../common/optional/sops.nix
    ../../common/optional/ssh.nix
    ../../common/optional/term-extra
  ];

  services.ssh-agent.enable = true;
}
