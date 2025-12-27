{ pkgs, ... }: {
  # Import all modules
  imports = [
    ./packages.nix
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/lazygit.nix
    ./programs/nodejs.nix
    ./programs/alacritty.nix
    ./programs/tmux.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "kokiyamaguchi";
  home.homeDirectory = "/Users/kokiyamaguchi";

  # Enable XDG directories
  xdg.enable = true;

  # Enable font management
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

   # SSH設定: OpenSSHを有効化して ~/.ssh/config を宣言的に管理
  programs.ssh = {
    enable = true;
    # 必要なら knownHosts を明示
    # knownHosts = {
    #   "ssh.dev.azure.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI...";
    # };
    extraConfig = ''
      Host ssh.dev.azure.com
        HostName ssh.dev.azure.com
        User git
        IdentityFile ~/.ssh/azure_devops_business
        AddKeysToAgent yes
        UseKeychain yes

      # 任意: GitHub等を使うならこちらも
      Host github.com
        HostName github.com
        User git
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519
    '';
  };

  # 初回だけ鍵をssh-agent＋Keychainへ登録する（存在チェック付きで冪等）
  # macOS限定の --apple-use-keychain を使う
  home.activation.addSshKeys = pkgs.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    KEY="${HOME}/.ssh/azure_devops_business"
    if [ -f "$KEY" ]; then
      # ssh-agent を起動（既に起動済みでもOK）
      eval "$(${pkgs.openssh}/bin/ssh-agent -s)"
      # すでにagentに載っているか確認
      if ! ${pkgs.openssh}/bin/ssh-add -l | grep -q "$KEY"; then
        # Keychainに保存しつつ追加（この時だけパスフレーズ入力が必要）
        ${pkgs.openssh}/bin/ssh-add --apple-use-keychain "$KEY" || true
      fi
    fi
  '';

  # Copy dotfiles that don't have native Home Manager support
  home.file = {
    ".config/nvim".source = ./dotfiles/nvim;
    ".czrc".source = ./dotfiles/czrc;
  };
}
