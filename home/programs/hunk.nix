{ inputs, ... }: {
  # modem-dev/hunk: レビュー優先のターミナル diff ビューア
  imports = [ inputs.hunk.homeManagerModules.default ];

  programs.hunk = {
    enable = true;
    # git pager 連携は OFF。delta を pager にしているため競合を避ける。
    # hunk は `hunk diff` / `hunk show` の明示コマンドで使う。
    enableGitIntegration = false;
    settings = {
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };
}
