{ ... }: {
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      orientation = "bottom";
      tilesize = 48;
      show-recents = false;
      minimize-to-application = true;
      mru-spaces = false;
      show-process-indicators = true;
      persistent-apps = [];
      persistent-others = [];
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      _FXShowPosixPathInTitle = true;
    };

    # Global macOS settings
    NSGlobalDomain = {
      # Mouse and trackpad
      "com.apple.mouse.scaling" = 2.5;
      "com.apple.trackpad.scaling" = 3.0;
      AppleShowScrollBars = "WhenScrolling";

      # Keyboard
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false;

      # Window and UI
      NSAutomaticWindowAnimationsEnabled = false;
      AppleShowAllFiles = true;

      # Text editing
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # Menu and toolbar
      AppleInterfaceStyle = "Dark";
      _HIHideMenuBar = false;
    };

    # Trackpad settings
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
      TrackpadRightClick = true;
    };

    # Screenshot settings
    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
      disable-shadow = false;
    };

    # Menu extra (system tray icons)
    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 1;
    };

    # Login window
    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };

    # Other settings
    ActivityMonitor = {
      IconType = 5;
      ShowCategory = 100;
    };

    # Spaces
    spaces.spans-displays = false;
  };

  # Keyboard
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
