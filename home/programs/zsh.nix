{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    dotDir = "${config.xdg.configHome}/zsh";

    shellAliases = {
      ls = "ls -F --color=auto";
      vim = "nvim";
      czg = "cz";
      ll = "ls -l";
      la = "ls -A";
      lla = "ls -l -A";
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

      # Lang
      export LANGUAGE="en_US.UTF-8"
      export LANG="''${LANGUAGE}"
      export LC_ALL="''${LANGUAGE}"
      export LC_CTYPE="''${LANGUAGE}"

      # Editor
      export EDITOR=vim
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
