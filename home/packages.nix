{ pkgs, ... }: {
  home.packages = with pkgs; [
    fzf
    gcc
    gh
    ghq
    git-delta
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
    protobuf
    starship
    tree
    uv
  ];
}
