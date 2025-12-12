{ pkgs, ... }: {
  home.packages = with pkgs; [
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
  ];
}
