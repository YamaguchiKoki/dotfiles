{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.hack
    fzf
    gcc
    gh
    ghq
    delta  # git-delta
    go
    jq
    k6
    lazygit
    lefthook
    mise
    ripgrep
    neovim
    nodejs
    nodePackages.pnpm
    cz-cli
    protobuf
    starship
    tree
    uv
    typescript
    dotnetCorePackages.sdk_9_0-bin
    azure-cli
    pkgs.shopify-cli
    pkgs.sqlcmd
    pkgs.yazi
    pkgs.helix

    # Helix用LSPサーバー
    # Go
    gopls                              # Go言語サーバー
    golangci-lint-langserver          # Go linter言語サーバー
    delve                             # Goデバッガー

    # TypeScript/JavaScript
    nodePackages.typescript-language-server  # TypeScript言語サーバー
    nodePackages.vscode-langservers-extracted  # HTML/CSS/JSON/ESLint言語サーバー

    # C#
    omnisharp-roslyn                  # C#言語サーバー

    # Markdown
    marksman                          # Markdown言語サーバー

    # YAML
    yaml-language-server              # YAML言語サーバー

    # Nix
    nil                               # Nix言語サーバー
    nixd                              # Nix言語サーバー（代替）

    # Lua
    lua-language-server               # Lua言語サーバー
  ];
}
