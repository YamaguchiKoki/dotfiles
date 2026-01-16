{ pkgs, lib, ... }: {
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
    # Suppress deprecation warning
    enableDefaultConfig = false;

    # 必要なら knownHosts を明示
    # knownHosts = {
    #   "ssh.dev.azure.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI...";
    # };

    matchBlocks = {
      # Default settings for all hosts
      "*" = {
        forwardAgent = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        compression = false;
        addKeysToAgent = "no";
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };

      "ssh.dev.azure.com" = {
        hostname = "ssh.dev.azure.com";
        user = "git";
        identityFile = "~/.ssh/azure_devops_business";
        addKeysToAgent = "yes";
        extraOptions = {
          UseKeychain = "yes";
        };
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        addKeysToAgent = "yes";
        extraOptions = {
          UseKeychain = "yes";
        };
      };
    };
  };

  # 初回だけ鍵をssh-agent＋Keychainへ登録する（存在チェック付きで冪等）
  # macOS限定の --apple-use-keychain を使う
  home.activation.addSshKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    KEY="$HOME/.ssh/azure_devops_business"
    if [ -f "$KEY" ]; then
      # macOSのシステム ssh/ssh-agent/ssh-add を使う（Keychain対応）
      eval "$(/usr/bin/ssh-agent -s)"
      if ! /usr/bin/ssh-add -l 2>/dev/null | grep -q "$KEY"; then
        /usr/bin/ssh-add --apple-use-keychain "$KEY" || true
      fi
    fi
  '';




  # Copy dotfiles that don't have native Home Manager support
  home.file = {
    ".config/nvim".source = ./dotfiles/nvim;
    ".czrc".source = ./dotfiles/czrc;

    # yazi / helix / lazygit 連携設定
    ".config/helix/config.toml".source = ./dotfiles/helix/config.toml;
    ".config/helix/languages.toml".source = ./dotfiles/helix/languages.toml;
    ".config/yazi/keymap.toml".source = ./dotfiles/yazi/keymap.toml;
    ".config/yazi/yazi.toml".source = ./dotfiles/yazi/yazi.toml;
  };
}
