{ pkgs, ... }: {
  # Homebrewなしで、brew-nixを使ってcaskアプリケーションを管理
  # 使い方: pkgs.brewCasks.アプリ名 でcaskアプリケーションをインストール
  #
  # 注意事項:
  # - 一部のアプリケーションは非標準の場所から実行できない場合があります
  # - 約700のcaskにはハッシュが欠けているため、手動でハッシュを提供する必要があります
  # - 複数の世代で大量のディスク容量を消費する可能性があります
  #
  # 利用可能なcaskを検索:
  # $ nix search github:BatteredBunny/brew-nix アプリ名

  home.packages = with pkgs.brewCasks; [
    # ターミナル
    ghostty

    # ユーティリティ
    cheatsheet

    # ブラウザ
    # google-chrome
    # firefox

    # 開発ツール
    # visual-studio-code
    # docker

    # その他のユーティリティ
    # 1password
    # slack
    # discord

    # 以下に使いたいcaskアプリケーションを追加してください
    # 例:
    # iterm2
    # notion
    # spotify
  ];
}
