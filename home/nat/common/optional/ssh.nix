{
  programs.ssh = {
    enable = true;
    settings."*" = {
      addKeysToAgent = "yes";
      # These values are from the default config;
      # the default is going away at some point, and currently raises a warning.
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

  services.ssh-agent.enable = true;
}
