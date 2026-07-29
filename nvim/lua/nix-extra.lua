local path = vim.fn.expand '$XDG_CONFIG_HOME/nvim-nix/init.lua'

if vim.fn.filereadable(path) == 1 then
  dofile(path)
end
