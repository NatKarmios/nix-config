{
  lib,
  config,
  ...
}:
let
  ssh-dir = "${config.home.homeDirectory}/.ssh";
in
{
  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      key = "${ssh-dir}/id_ed25519";
      signByDefault = true;
    };
    extraConfig.gpg.ssh.allowedSignersFile = "${ssh-dir}/allowed_signers";
    settings = {
      user.name = lib.mkDefault config.hostSpec.userFullName;
      user.email = lib.mkDefault config.hostSpec.email;
      init.defaultBranch = "main";
      credential.helper = "store";

      alias = {
        oreset = ''!bash -c "git reset origin/$(git branch --show-current) --hard"'';
        unwip = ''!bash -c "git oreset; git reset HEAD^"'';
        wip = ''!bash -c "git add -A; git commit -m \"WIP\" --no-verify; git push --set-upstream origin -f"'';
      };
    };
  };
}
