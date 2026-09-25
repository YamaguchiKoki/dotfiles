{ inputs, ... }: {
  # modem-dev/hunk: レビュー優先のターミナル diff ビューア
  imports = [ inputs.hunk.homeManagerModules.default ];

  programs.hunk = {
    enable = true;
    # git pager 連携は OFF。delta を pager にしているため競合を避ける。
    # hunk は `hunk diff` / `hunk show` の明示コマンドで使う。
    enableGitIntegration = false;
    # 設定は dotfiles/hunk/config.toml で管理するため settings は空のままにする
    # (settings を書くとモジュールが同じ config.toml を生成して衝突する)
  };

  xdg.configFile."hunk/config.toml".source = ../dotfiles/hunk/config.toml;
}
