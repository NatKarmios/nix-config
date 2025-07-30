{ lib, ... }:
with lib.custom.nixvim;
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };

      keymaps =
        with bind-helpers;
        toAttrKeymap [
          (n' "<leader>fh" "help_tags" "[F]ind [H]elp")
          (n' "<leader>fk" "keymaps" "[F]ind [K]eymaps")
          (n' "<leader>ff" "find_files" "[F]ind [F]iles")
          (n' "<leader>fF" "builtin" "[F]ind Telescope [F]inders")
          (n' "<leader>fw" "grep_string" "[F]ind current [W]ord")
          (n' "<leader>fg" "live_grep" "[F]ind by [G]rep")
          (n' "<leader>fd" "diagnostics" "[F]ind [D]iagnostics")
          (n' "<leader>fr" "resume" "[F]ind [R]esume")
          (n' "<leader>f." "oldfiles" "[F]ind recent files")
          (n' "<leader><leader>" "buffers" "Find existing buffers")
        ];
    };

    # Keymaps given direct to Telescope don't allow raw actions;
    # just set them in the top-level keymap here
    keymaps =
      with bind-helpers;
      lib.flatten [
        (n' "<leader>/" (raw ''
          function()
            require('telescope.builtin').current_buffer_fuzzy_find(
              require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false
              }
            )
          end
        '') "Fuzzily search in current buffer")

        (n' "<leader>f/" (raw ''
          function()
            require('telescope.builtin').live_grep {
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files'
            }
          end
        '') "[F]ind in open files")

        (n' "<leader>fn" (raw ''
          function()
            require('telescope.builtin').find_files {
              cwd = vim.env.HOME .. '/src/nix/nix-config'
            }
          end
        '') "[F]ind [N]ix config files")
      ];
  };
}
