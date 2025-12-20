{ ... }: {
  # Primary user for user-level system defaults
  system.primaryUser = "kokiyamaguchi";

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
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
    };

    # Global macOS settings
    NSGlobalDomain = {
      # Scrollbar
      AppleShowScrollBars = "WhenScrolling";
      "com.apple.trackpad.scaling" = 3.0;

      # Keyboard
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false;

      # Window and UI
      NSAutomaticWindowAnimationsEnabled = false;

      # Text editing
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # Menu and toolbar
      AppleInterfaceStyle = "Dark";
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
    };

    # Login window
    loginwindow = {
      GuestEnabled = false;
    };
  };

  # Keyboard
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
