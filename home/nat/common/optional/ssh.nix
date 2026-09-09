{
  programs.ssh = {
    enable = true;
    settings."*" = {
      addKeysToAgent = "yes";
      forwardAgent = false;
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
    includes = [ "config_local" ];
    enableDefaultConfig = false;
  };
}
