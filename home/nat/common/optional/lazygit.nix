{
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "<c-space>";
          context = "files";
          command = "git add --intent-to-add {{.SelectedFile.Name | quote}}";
          description = "Intent-to-commit";
        }
      ];
    };
  };
}

