{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;
    colorschemes.catppuccin.enable = true;

    globals = {
      have_nerd_font.__raw = ''
        vim.env.TERM ~= "linux"
      '';
    };

    opts = {
      number = true;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
    };

    plugins = {
      numbertoggle.enable = true;
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rust_analyzer.enable = true;
        };
      };
    };
  };
}

