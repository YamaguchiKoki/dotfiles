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
  ];
}
