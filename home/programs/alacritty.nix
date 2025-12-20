{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = [ "new-session" "-A" "-s" "main" ];
      };
      general = {
        import = [
          "${pkgs.alacritty-theme}/miasma.toml"
        ];
        live_config_reload = true;
      };

      window = {
        dimensions = {
          columns = 200;
          lines = 60;
        };
        padding = {
          x = 8;
          y = 4;
        };
        opacity = 0.85;
        startup_mode = "Fullscreen";  # or "Maximized"
      };

      cursor = {
        style = "Beam";
      };

      scrolling = {
        history = 100000;
        multiplier = 3;
      };

      keyboard.bindings = [
        # 新しいウィンドウ作成: Command + T
        { key = "T"; mods = "Command"; chars = ''\u0002c''; }

        # 横分割(上下): Command + D
        { key = "D"; mods = "Command"; chars = ''\u0002"''; }

        # 縦分割(左右): Command + Shift + D
        { key = "D"; mods = "Command|Shift"; chars = ''\u0002%''; }

        # window移動: Shift + ←/→
        { key = "Left"; mods = "Shift"; chars = ''\u0002p''; }
        { key = "Right"; mods = "Shift"; chars = ''\u0002n''; }

        # コピーモードに入る: Command + [
        { key = "LBracket"; mods = "Command"; chars = ''\u0002[''; }

        # ペイン/ウィンドウを閉じる（確認なし）: Command + W
        { key = "W"; mods = "Command"; chars = ''\u0002w''; }

        # ペイン移動: Command + h/j/k/l
        { key = "H"; mods = "Command"; chars = ''\u0002h''; }  # 左
        { key = "J"; mods = "Command"; chars = ''\u0002j''; }  # 下
        { key = "K"; mods = "Command"; chars = ''\u0002k''; }  # 上
        { key = "L"; mods = "Command"; chars = ''\u0002l''; }  # 右

        # ペインサイズ調整: Command + 矢印キー
        { key = "Left"; mods = "Command"; chars = ''\u0002H''; }   # 左に拡大
        { key = "Right"; mods = "Command"; chars = ''\u0002L''; }  # 右に拡大
        { key = "Up"; mods = "Command"; chars = ''\u0002K''; }     # 上に拡大
        { key = "Down"; mods = "Command"; chars = ''\u0002J''; }   # 下に拡大

        # Shift + Enter で改行
        { key = "Return"; mods = "Shift"; chars = "\n"; }
      ];

      font = {
        normal = {
          family = "HackGen Console NF";
          style = "Regular";
        };
        bold = {
          family = "HackGen Console NF";
          style = "Bold";
        };
        size = 14.0;
        offset = {
          x = 0;
          y = 2;
        };
      };
    };
  };
}
