{ pkgs, config, ... }: {
  # zoxide設定
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;  # Ctrl-R 履歴 / Ctrl-T ファイル補完
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
      export PATH=''${HOME}/.cargo/bin:$PATH

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
      export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:$HOME/projects/git/personal/ac-library"

      # Custom function
      qcd() {
        case "$1" in
          p)
            cd $HOME/projects/git/personal
            ;;
          b)
            cd $HOME/projects/git/business
            ;;
          *)
            echo "qcd: unknown key $1"
            return 1
          ;;
        esac
        pwd
      }
       eval "$(mise activate zsh)"
       eval "$(direnv hook zsh)"
       eval "$(git wt --init zsh)"

      # Markdown ライブプレビュー（herdr等で別ペインに開いて使う）
      # 使い方: mdp file.md  → 保存のたびに glow で再描画
      mdp() {
        local file="$1"
        if [[ -z "$file" ]]; then
          echo "usage: mdp <file.md>"
          return 1
        fi
        watchexec -w "$file" -r -c -- glow "$file"
      }

      # hpr <PR番号> : GitHub PR の差分を hunk でレビュー
      # gh pr diff は GitHub API 経由で 20000 行超のPRが 406 too_large で失敗するため、
      # ローカル git で差分を作って hunk に流す（checkout 不要・行数制限なし）。
      hpr() {
        local num="$1" base
        if [[ -z "$num" ]]; then
          echo "usage: hpr <PR番号>"
          return 1
        fi
        base=$(gh pr view "$num" --json baseRefName -q .baseRefName) || return 1
        git fetch -q origin "$base" "refs/pull/$num/head:refs/hpr/$num" || return 1
        git diff --no-color "origin/$base...refs/hpr/$num" | hunk patch -
      }

      # git-wt + fzf integration
      wt() {
        local branch
        branch=$(git wt | tail -n +2 | awk '{print $(NF-1)}' | fzf)
        [[ -n "$branch" ]] && git wt "$branch"
      }

      # sg <query> : ripgrep ライブ grep → 選択行を helix の該当行で開く
      # yazi や space+/ を経由せず、⌘⇧Space のクイックターミナルから即検索できる。
      sg() {
        local q="$*"
        local rg='rg --column --line-number --no-heading --color=always --smart-case'
        FZF_DEFAULT_COMMAND="$rg -- \"$q\"" \
          fzf --ansi --disabled --query "$q" \
              --bind "change:reload:$rg -- {q} || true" \
              --bind "enter:become(hx {1}:{2})" \
              --delimiter : \
              --preview 'bat --color=always {1} --highlight-line {2} --style=numbers,changes' \
              --preview-window 'right,60%,border-left,+{2}+3/3'
      }
    '';
  };
}
