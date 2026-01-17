{ pkgs, ... }: {
  # Ghostty configuration
  xdg.configFile."ghostty/config".text = ''
    # Ghostty Configuration

    # Theme
    theme = Espresso Libre

    # Font
    font-family = "UDEV Gothic NF"

    # Keybindings
    keybind = shift+enter=text:\x0a
    keybind = global:cmd+shift+space=toggle_quick_terminal
  '';
}
