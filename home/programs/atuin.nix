{ ... }: {
  # atuin: シェル履歴を SQLite に保存し、Ctrl-R でディレクトリ・終了コード付きで検索する
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    # ↑キーは historySubstringSearch に任せ、atuin は Ctrl-R のみ担当する
    flags = [ "--disable-up-arrow" ];
    settings = {
      # 履歴はローカルのみ（社内DBの接続情報などを外部サーバーに同期しない）
      auto_sync = false;
      update_check = false;
      style = "compact";
      inline_height = 20;
      # 起動直後はいまのディレクトリの履歴に絞る（Ctrl-R を押すたびに切り替わる）
      filter_mode_shell_up_key_binding = "directory";
      # パスワードを含みがちなコマンドは記録しない
      history_filter = [
        "PWD="
        "-P "
        "password"
      ];
    };
  };
}
