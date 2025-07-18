{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    plugins.glance = {
      enable = true;
      settings = {
        list.position = "left";
      };
    };

    keymaps = with bind-helpers; lib.flatten [
      (n' "gd" (cmd "Glance definitions") "[G]oto [D]efinition")
      (n' "gr" (cmd "Glance references") "[G]oto [R]eferences")
      (n' "gi" (cmd "Glance implementations") "[G]oto [I]mplementation")
      (n' "gt" (cmd "Glance type_definitions") "[G]oto [T]ype definition")
    ];
  };
}

