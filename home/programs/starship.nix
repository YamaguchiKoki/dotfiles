{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      # シェルプロンプトの間に空行を追加
      add_newline = true;

      format = ''
        [](fg:#7aa2f7)$os[ ](fg:#7aa2f7 bg:#1a1b26)$directory$git_branch$git_status$git_metrics[](fg:#1a1b26)$fill([](fg:#1a1b26)$nodejs[](fg:208 bg:#1a1b26)$package)([](fg:#1a1b26)$golang(bg:#1a1b26))
        $character'';

      right_format = "$cmd_duration$time";

      os = {
        format = "[$symbol]($style)";
        style = "fg:#1a1b26 bg:#7aa2f7";
        disabled = false;
        symbols = {
          Macos = "  ";
        };
      };

      character = {
        success_symbol = "[󰀵 > ](bold green)";
        error_symbol = "[ > ](bold red)";
      };

      status = {
        style = "red";
        symbol = "🔴";
        format = "[$common_meaning$signal_name$maybe_int $status]($style) ";
        map_symbol = true;
        disabled = false;
      };

      directory = {
        truncation_length = 6;
        truncation_symbol = " ";
        truncate_to_repo = false;
        home_symbol = " ~";
        style = "fg:#7aa2f7 bg:#1a1b26";
        read_only = " 󰌾 ";
        read_only_style = "fg:#f7768e bg:#1a1b26";
        format = "[$path]($style)[$read_only]($read_only_style)";
      };

      git_branch = {
        symbol = "  ";
        truncation_symbol = "";
        style = "fg:#7aa2f7 bg:#1a1b26";
        format = "[  $symbol$branch(:$remote_branch)]($style)";
      };

      git_status = {
        style = "fg:#e0af68 bg:#1a1b26";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕";
        up_to_date = "✓";
        untracked = "?";
        stashed = "$";
        modified = "!\${count}";
        renamed = "»";
        deleted = "✘";
        format = "([$all_status$ahead_behind]($style))";
      };

      git_metrics = {
        added_style = "fg:#9ece6a bg:#1a1b26";
        deleted_style = "fg:#9ece6a bg:#1a1b26";
        format = "[+$added/-$deleted]($deleted_style)";
        disabled = false;
      };

      fill = {
        symbol = "─";
        style = "blue";
      };

      nodejs = {
        symbol = " ";
        style = "fg:#9ece6a bg:#1a1b26";
        format = "[via $symbol($version )]($style)";
      };

      golang = {
        symbol = "  󰟓 ";
        style = "fg:#79d4fd bg:#1a1b26";
        format = "[via $symbol($version )]($style)";
      };

      package = {
        format = "[ $symbol$version ]($style)";
        style = "fg:#000000 bg:208";
      };

      cmd_duration = {
        min_time = 1;
        style = "fg:#e0af68";
        format = "[   $duration]($style)";
      };

      time = {
        disabled = false;
        style = "fg:#73daca";
        format = "[   $time]($style)";
        time_format = "%T";
        utc_time_offset = "+9";
      };
    };
  };
}
