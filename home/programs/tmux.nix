{ config, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;

    extraConfig = ''
      # ウィンドウを切り替える
      bind -n S-left previous-window
      bind -n S-right next-window

      # prefix+r で設定のリロード
      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display "Reloaded!"

      # PaneをVim-likeに移動する
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      # ペインサイズ調整（prefix + H/J/K/L）
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # ステータスバーを上部に表示する
      set -g status-position top

      # focus-events有効化
      set -g focus-events on

      # コピーモード設定
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"
    '';
  };
}
