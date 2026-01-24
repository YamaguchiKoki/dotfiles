{ pkgs, config, ... }: {
  # zoxide設定
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    dotDir = "${config.xdg.configHome}/zsh";

    shellAliases = {
      # eza (modern ls replacement)
      ls = "eza --icons";
      ll = "eza -l --icons --git";
      la = "eza -a --icons";
      lla = "eza -la --icons --git";
      tree = "eza --tree --icons";

      # エディタ
      vim = "hx";      # vimコマンドでhelixを起動
      vi = "hx";       # viコマンドでhelixを起動
      nvim = "hx";     # nvimコマンドでhelixを起動

      # その他
      czg = "cz";
      lg = "lazygit";
    };


    history = {
      size = 100000;
      save = 100000;
      path = "$HOME/.config/zsh/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      extended = true;
    };

    historySubstringSearch.enable = true;

    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = ''
      # XDG
      export XDG_CONFIG_HOME=''${HOME}/.config
      export XDG_CACHE_HOME=''${HOME}/.cache
      export XDG_DATA_HOME=''${HOME}/.local/share
      export XDG_STATE_HOME=''${HOME}/.local/state

      # Path
      export PATH=''${HOME}/.local/bin:$PATH
      export PATH="/usr/local/sbin:$PATH"
      export PATH=''${HOME}/.cache/.bun/bin:$PATH

      # Lang
      export LANGUAGE="en_US.UTF-8"
      export LANG="''${LANGUAGE}"
      export LC_ALL="''${LANGUAGE}"
      export LC_CTYPE="''${LANGUAGE}"

      # Editor
      export EDITOR=hx
      export VISUAL=hx
      export CVSEDITOR="''${EDITOR}"
      export SVN_EDITOR="''${EDITOR}"
      export GIT_EDITOR="''${EDITOR}"

      # Setting
      umask 022
      limit coredumpsize 0
      bindkey -e

      # Zsh options
      export LISTMAX=50
      unsetopt bg_nice
      setopt list_packed
      setopt no_beep
      unsetopt list_types

      # C++ Include Path
      export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:$HOME/Documents/projects/git/personal/ac-library"

      # Custom function
      qcd() {
        case "$1" in
          p)
            cd $HOME/Documents/projects/git/personal
            ;;
          b)
            cd $HOME/Documents/projects/git/business
            ;;
          *)
            echo "qcd: unknown key $1"
            return 1
          ;;
        esac
        pwd
      }
    '';
  };
}
