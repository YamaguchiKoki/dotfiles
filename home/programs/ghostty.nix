{ pkgs, ... }: {
  # Ghostty configuration
  xdg.configFile."ghostty/config".text = ''
    # Ghostty Configuration

    # --- 見た目・フォント ---
    # フォントサイズ
    font-size = 14
    # 行間を少し広げてモダンにする
    adjust-cell-height = 10%
    # フォントファミリー
    font-family = "UDEV Gothic NF"

    # テーマ
    theme = Espresso Libre

    # --- ウィンドウ・透明度 ---
    # 背景を透過させてブラー（すりガラス効果）を入れる
    background-opacity = 0.90
    background-blur-radius = 20

    # ウィンドウ内の余白を入れて圧迫感を減らす
    window-padding-x = 10
    window-padding-y = 10
    window-padding-balance = true

    # --- Macネイティブな挙動 ---
    # タイトルバーを透明にしてスッキリさせる
    macos-titlebar-style = transparent
    # フルスクリーン時にMac標準の挙動にする
    macos-window-shadow = true
    # 入力中はマウスカーソルを隠す
    mouse-hide-while-typing = true

    # --- 操作性 ---
    # 選択しただけでクリップボードにコピー
    copy-on-select = true
    # クリップボードの読み書きを許可
    clipboard-read = allow
    clipboard-write = allow

    # --- Keybindings ---
    keybind = shift+enter=text:\x0a
    keybind = global:cmd+shift+space=toggle_quick_terminal
  '';
}
