{ pkgs, config, ... }: {
  # Configure npm to use project-local packages only
  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global-disabled";
  };

  # Create npmrc that discourages global installs
  home.file.".config/npm/npmrc".text = ''
    # Configured by Home Manager
    # Global installs are disabled - use packages.nix instead

    # To add a package:
    # 1. Search: nix search nixpkgs nodePackages.<name>
    # 2. Add to: ~/nix-config/home/packages.nix
    # 3. Rebuild: darwin-rebuild switch --flake ~/nix-config

    prefix=${config.home.homeDirectory}/.npm-global-disabled

    # Project-local settings
    cache=${config.xdg.cacheHome}/npm
    audit=true
    fund=false
    progress=true
    loglevel=warn
  '';

  # Create helper script to search for npm packages in nixpkgs
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
    echo "To install, add to ~/nix-config/home/packages.nix:"
    echo "  nodePackages.$1"
  '';

  home.file.".local/bin/nix-npm-search".executable = true;
}
