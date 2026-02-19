{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    terminal = "tmux-256color";
    historyLimit = 50000;
    escapeTime = 0;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";

    extraConfig = ''
      # Terminal true colour support
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g display-time 4000
      set -g status-interval 5
      set -g focus-events on
      setw -g pane-base-index 1
      set -g renumber-windows on

      # Pane resize (prefix + hjkl)
      bind h resize-pane -L 5
      bind j resize-pane -D 5
      bind k resize-pane -U 5
      bind l resize-pane -R 5

      # Alt+hjkl pane switching without prefix
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Splits in current path
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Vi copy mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"

      # -- Nord palette --
      set -g status-position top
      set -g status-style "bg=#3B4252,fg=#D8DEE9"
      set -g status-left "#[bg=#5E81AC,fg=#ECEFF4,bold] #S #[bg=#3B4252] "
      set -g status-left-length 30
      set -g status-right "#[fg=#D8DEE9]%H:%M #[fg=#4C566A]| #[fg=#D8DEE9]%d-%b "
      set -g status-right-length 40
      setw -g window-status-current-format "#[bg=#434C5E,fg=#88C0D0,bold] #I:#W "
      setw -g window-status-format "#[fg=#4C566A] #I:#W "
      setw -g window-status-separator ""

      set -g pane-border-style "fg=#3B4252"
      set -g pane-active-border-style "fg=#88C0D0"
      set -g message-style "bg=#3B4252,fg=#88C0D0"
      set -g message-command-style "bg=#3B4252,fg=#88C0D0"
      setw -g mode-style "bg=#4C566A,fg=#D8DEE9"
    '';
  };
}
