{ pkgs, config, ... }: {
  # Configure npm for hybrid approach (allow npm install -g)
  home.sessionVariables = {
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_PREFIX = "${config.xdg.dataHome}/npm";
  };

  # Add npm global bin directory to PATH
  home.sessionPath = [
    "${config.xdg.dataHome}/npm/bin"
  ];

  # Create npmrc configuration
  home.file."${config.xdg.configHome}/npm/npmrc".text = ''
    # Managed by Home Manager
    # Global packages will be installed to: ~/.local/share/npm
    prefix=${config.xdg.dataHome}/npm
    cache=${config.xdg.cacheHome}/npm

    # Security
    audit=true
    audit-level=moderate

    # UI
    fund=false
    progress=true
    loglevel=warn

    # Performance
    engine-strict=false
    prefer-offline=true
  '';

  # Helper script to list globally installed npm packages
  home.file.".local/bin/npm-global-list".text = ''
    #!/usr/bin/env bash
    # List globally installed npm packages
    echo "=== Globally installed npm packages ==="
    npm list -g --depth=0
    echo ""
    echo "=== Consider adding these to home/packages.nix: ==="
    echo "# Check available packages: nix search nixpkgs nodePackages.<name>"
  '';

  home.file.".local/bin/npm-global-list".executable = true;

  # Keep nix-npm-search for reference
  home.file.".local/bin/nix-npm-search".text = ''
    #!/usr/bin/env bash
    # Search for npm packages available in nixpkgs

    if [ -z "$1" ]; then
      echo "Usage: nix-npm-search <package-name>"
      echo "Example: nix-npm-search typescript"
      exit 1
    fi

    echo "Searching for nodePackages.$1 in nixpkgs..."
    nix search nixpkgs "nodePackages.$1"

    echo ""
    echo "To install via Nix, add to ~/nix-config/home/packages.nix:"
    echo "  nodePackages.$1"
  '';

  home.file.".local/bin/nix-npm-search".executable = true;
}
