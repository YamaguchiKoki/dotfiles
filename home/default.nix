{ pkgs, ... }: {
  # Import all modules
  imports = [
    ./packages.nix
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/lazygit.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "kokiyamaguchi";
  home.homeDirectory = "/Users/kokiyamaguchi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
