# パッケージ管理の仕組み

このドキュメントでは、nix-configプロジェクトにおけるパッケージ管理の仕組みを解説します。

## 目次

- [概要](#概要)
- [使用しているツール](#使用しているツール)
- [ディレクトリ構造](#ディレクトリ構造)
- [パッケージの種類と管理方法](#パッケージの種類と管理方法)
- [パッケージの追加方法](#パッケージの追加方法)
- [設定の適用](#設定の適用)
- [トラブルシューティング](#トラブルシューティング)

## 概要

このプロジェクトでは、macOS環境を**宣言的**に管理しています。つまり、「どのパッケージをインストールする」「どの設定を適用する」といった情報をNixファイルに記述することで、環境を再現可能にしています。

### 主な利点

- **再現性**: 設定ファイルをコピーするだけで、同じ環境を別のMacでも再現可能
- **バージョン管理**: Git で設定の変更履歴を管理
- **ロールバック**: 問題が発生した場合、以前の設定に簡単に戻せる
- **Homebrewなし**: brew-nixを使うことで、Homebrew をインストールせずにcaskアプリケーションを管理

## 使用しているツール

### 1. Nix

パッケージマネージャー。すべての基盤となるツールです。

### 2. nix-darwin

macOS用のシステム設定管理ツール。Dockの設定やFinderの設定など、macOS全体の設定を宣言的に管理します。

### 3. home-manager

ユーザーレベルの設定とパッケージを管理するツール。ドットファイルや各種プログラムの設定を管理します。

### 4. nix-homebrew

Homebrewのインストールとバージョンを宣言的に管理するツール。nix-darwinと連携して、Homebrew自体もNixで完全管理します。

### 5. Homebrew

macOS用のパッケージマネージャー。GUIアプリケーション（Cask）の管理に使用します。nix-homebrewとnix-darwinにより宣言的に管理されます。

## ディレクトリ構造

```
nix-config/
├── flake.nix              # プロジェクトのエントリーポイント
├── flake.lock             # 依存関係のロックファイル
├── home/                  # ユーザー設定（home-manager）
│   ├── default.nix        # home-managerの設定をまとめるファイル
│   ├── packages.nix       # CLIツールのパッケージ一覧
│   ├── programs/          # 各プログラムの詳細設定
│   │   ├── git.nix        # Gitの設定
│   │   ├── zsh.nix        # Zshの設定
│   │   ├── tmux.nix       # tmuxの設定
│   │   └── ...
│   └── dotfiles/          # 設定ファイル本体
│       ├── nvim/          # Neovim設定
│       └── ...
├── system/                # システム設定（nix-darwin）
│   ├── defaults.nix       # macOSシステム設定
│   └── homebrew.nix       # Homebrewパッケージ管理
└── doc/                   # ドキュメント
    └── package-management.md
```

## パッケージの種類と管理方法

このプロジェクトでは、3種類のパッケージを管理しています。

### 1. CLIツール（コマンドラインツール）

**管理ファイル**: `home/packages.nix`

Nixpkgsから提供される通常のCLIツール（ripgrep、fzf、gitなど）。

```nix
{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fzf
    gh
    # ... その他のCLIツール
  ];
}
```

### 2. GUIアプリケーション（Homebrew Cask）

**管理ファイル**: `system/homebrew.nix`

Homebrew Caskとして提供されるmacOSアプリケーション（Chrome、VS Codeなど）をnix-darwinで宣言的に管理。

```nix
{ ... }: {
  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "google-chrome"
      "visual-studio-code"
      # ... その他のGUIアプリ
    ];
  };
}
```

**メリット**:
- アプリが `/Applications/` に配置され、Finderから起動可能
- Homebrewのバージョンも固定され、完全な再現性を実現
- 設定にないアプリは自動的に削除される

### 3. プログラム設定

**管理ディレクトリ**: `home/programs/`

home-managerが提供する設定モジュールを使って、各プログラムの設定を宣言的に管理。

例: `home/programs/git.nix`
```nix
{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "your.email@example.com";
    # ... その他のGit設定
  };
}
```

## パッケージの追加方法

### CLIツールを追加する場合

1. `home/packages.nix` を開く
2. `home.packages` リストにパッケージ名を追加

```nix
home.packages = with pkgs; [
  # 既存のパッケージ
  ripgrep
  fzf

  # 新しく追加
  btop  # システムモニター
];
```

### GUIアプリケーション（Cask）を追加する場合

1. 利用可能なcaskを検索
   ```bash
   brew search アプリ名
   ```

2. `system/homebrew.nix` を開く
3. `homebrew.casks` リストにcask名を追加

```nix
homebrew = {
  enable = true;
  casks = [
    "ghostty"
    "keyclu"

    # 新しく追加
    "visual-studio-code"
    "slack"
  ];
};
```

### プログラム設定を追加する場合

1. `home/programs/` 配下に新しい `.nix` ファイルを作成

   例: `home/programs/bat.nix`
   ```nix
   { pkgs, ... }: {
     programs.bat = {
       enable = true;
       config = {
         theme = "TwoDark";
       };
     };
   }
   ```

2. `home/default.nix` の `imports` リストに追加
   ```nix
   imports = [
     ./packages.nix
     ./casks.nix
     ./programs/git.nix
     ./programs/bat.nix  # 新しく追加
     # ... その他
   ];
   ```

## 設定の適用

### 変更を適用する

設定ファイルを編集した後、以下のコマンドで変更を適用します。

```bash
darwin-rebuild switch --flake ~/nix-config#MacBook-Pro-2
```

または、プロジェクトディレクトリ内で:

```bash
darwin-rebuild switch --flake .#MacBook-Pro-2
```

### ビルドのみ（適用はしない）

設定が正しいか確認したい場合:

```bash
darwin-rebuild build --flake .#MacBook-Pro-2
```

### 変更内容を確認する

適用前に何が変わるか確認:

```bash
darwin-rebuild build --flake .#MacBook-Pro-2
nix store diff-closures /run/current-system ./result
```

## トラブルシューティング

### パッケージが見つからない

**問題**: `error: attribute 'パッケージ名' missing`

**解決方法**:
1. パッケージ名が正しいか確認
   ```bash
   nix search nixpkgs パッケージ名
   ```
2. Nixpkgsを更新
   ```bash
   nix flake update
   ```

### Homebrewアプリが見つからない

**問題**: `brew search` でアプリが見つからない

**解決方法**:
1. Homebrewのデータベースを更新
   ```bash
   brew update
   ```
2. 正確なcask名を確認
   ```bash
   brew search --cask アプリ名
   ```

### ビルドが遅い・ディスク容量を圧迫

**問題**: 複数の世代が蓄積してディスク容量を消費

**解決方法**:
古い世代を削除してガベージコレクションを実行

```bash
# 古い世代を削除
nix-collect-garbage -d

# より積極的に削除（30日以上前の世代）
nix-collect-garbage --delete-older-than 30d

# Homebrewのキャッシュも削除
brew cleanup
```

### ロールバック

**問題**: 新しい設定で問題が発生した

**解決方法**:
以前の世代に戻す

```bash
# 世代一覧を表示
darwin-rebuild --list-generations

# 特定の世代にロールバック
darwin-rebuild switch --rollback
```

## 参考リンク

- [Nix公式ドキュメント](https://nixos.org/manual/nix/stable/)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [home-manager](https://github.com/nix-community/home-manager)
- [nix-homebrew](https://github.com/zhaofengli/nix-homebrew)
- [Homebrew](https://brew.sh/)
- [Nixpkgsパッケージ検索](https://search.nixos.org/packages)
