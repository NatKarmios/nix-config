{ pkgs, inputs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"

          # These need to be set *before* status modules are declared!
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_date_time_text " %H:%M"

          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_text "#W"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
        '';
      }
      {
        plugin = inputs.tmux-sessionx.packages.${pkgs.system}.default;
        extraConfig = ''
          set -g @sessionx-bind 'S'
          set -g @sessionx-zoxide-mode 'on'
        '';
      }
    ];

    # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      #hjkl pane switching
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      #fix home/end
      bind -n Home send Escape "OH"
      bind -n End send Escape "OF"
      bind R source-file ~/.config/tmux/tmux.conf
      bind r command-prompt "rename-window %%"

      set -g history-limit 1000000  # increase from default 2000
      set -g renumber-windows on  # renumber windows when closing

      set -g status-position top
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-style "bg=#{E:@thm_base},fg=#cdd6f4"
      set -g status-right " #{E:@catppuccin_status_directory}"
      set -ag status-right " #{E:@catppuccin_status_date_time}"
      set -g status-left " #{E:@catppuccin_status_session}"

    '';
  };
}
