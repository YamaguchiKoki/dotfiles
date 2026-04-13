{ ... }: {
  # Zellij configuration — source 方式 ($ や '' を含む KDL コメントの
  # Nix string escape を避けるため external file にする
  xdg.configFile."zellij/config.kdl".source = ../dotfiles/zellij/config.kdl;
  xdg.configFile."zellij/layouts/default.kdl".source = ../dotfiles/zellij/layouts/default.kdl;
}
