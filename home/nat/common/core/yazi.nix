#
# Terminal file browser
#
{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    plugins = {
      drag = (
        pkgs.fetchFromGitHub {
          owner = "Joao-Queiroga";
          repo = "drag.yazi";
          rev = "3dff129c52b30d8c08015e6f4ef8f2c07b299d4b";
          hash = "sha256-nmFlh+zW3aOU+YjbfrAWQ7A6FlGaTDnq2N2gOZ5yzzc=";
        }
      );
    };
    keymap = {
      mgr.prepend_keymap = [
        { run = "plugin drag"; on = [ "<C-d>" ]; desc = "Drag files"; }
      ];
    };
  };

  home.packages = with pkgs; [ ripdrag ];
}
