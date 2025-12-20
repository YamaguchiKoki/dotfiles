{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Nerd Fonts
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
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
    tmux
  ];
}
