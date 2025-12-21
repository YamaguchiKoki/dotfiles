{ config, pkgs, ... }: {
  # Copy starship.toml to ~/.config/
  xdg.configFile."starship.toml".source = ../dotfiles/starship.toml;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
