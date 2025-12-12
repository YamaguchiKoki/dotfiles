{ ... }: {
  programs.git = {
    enable = true;
    # TODO: 既存の.gitconfigから設定を移行
    # userName = "Your Name";
    # userEmail = "your.email@example.com";
    # delta.enable = true;
  };
}
