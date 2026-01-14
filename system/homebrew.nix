{ ... }: {
  # Homebrewの宣言的管理
  # nix-homebrewがHomebrew自体をインストールし、nix-darwinが管理します
  #
  # メリット:
  # - アプリが/Applications/に配置され、Finderから起動可能
  # - Homebrewのバージョンも固定され、完全な再現性を実現
  # - 設定にないパッケージは自動的に削除される
  #
  # 利用可能なcaskを検索:
  # $ brew search アプリ名

  homebrew = {
    enable = true;

    # Homebrew Casks（GUIアプリケーション）
    casks = [
      # ターミナル
      "ghostty"

      # ユーティリティ
      "keyclu"  # キーボードショートカット表示ツール

      # 以下に使いたいアプリを追加してください
      # 例:
      # "google-chrome"
      # "visual-studio-code"
      # "slack"
      # "discord"
      # "1password"
    ];

    # Homebrew Formulae（CLIツール）
    # Nixで利用できないツールのみここに追加することを推奨
    brews = [
      # 例:
      # "mas"  # Mac App Store CLI
    ];

    # Homebrew Taps（追加のリポジトリ）
    taps = [
      # カスタムtapが必要な場合はここに追加
      # 例:
      # "homebrew/cask-fonts"
    ];

    # アクティベーション時の動作
    onActivation = {
      cleanup = "zap";  # 設定にないパッケージを完全に削除
      autoUpdate = true;  # Homebrewを自動更新
      upgrade = true;  # インストール済みパッケージを自動アップグレード
    };
  };
}
