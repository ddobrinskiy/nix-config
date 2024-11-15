{ pkgs, ... }:

  ###################################################################################
  #
  #  macOS's System configuration
  #
  #  All the configuration options are documented here:
  #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
  #
  ###################################################################################
{
  system = {
    stateVersion = 5;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # Set correct permissions for SSH keys
      echo "Setting SSH private key permissions..."
      chmod 600 /Users/david/.ssh/id_*
      echo "Setting SSH public key permissions..."
      chmod 644 /Users/david/.ssh/id_*.pub
      echo "Setting SSH known_hosts permissions..."
      chmod 644 /Users/david/.ssh/known_hosts

      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;  # show 24 hour clock

      # other macOS's defaults configuration.

      dock = {
        autohide = false;
        show-recents = false;  # disable recent apps
        mru-spaces = false;  # disable recent spaces

        # customize Hot Corners
        wvous-tr-corner = 13;  # top-right - Lock Screen
        wvous-br-corner = 4;  # bottom-right - Desktop
      };

      finder = {
        AppleShowAllExtensions = true;  # show all file extensions
        FXPreferredViewStyle = "clmv";  # default folder view is the columns view
      };

      # customize settings that not supported by nix-darwin directly
      # Incomplete list of macOS `defaults` commands :
      #   https://github.com/yannbertrand/macos-defaults
      NSGlobalDomain = {
        NSAutomaticCapitalizationEnabled = false;  # disable auto capitalization(自动大写)
        NSAutomaticDashSubstitutionEnabled = false;  # disable auto dash substitution(智能破折号替换)
        NSAutomaticPeriodSubstitutionEnabled = false;  # disable auto period substitution(智能句号替换)
        NSAutomaticQuoteSubstitutionEnabled = false;  # disable auto quote substitution(智能引号替换)
        NSAutomaticSpellingCorrectionEnabled = false;  # disable auto spelling correction(自动拼写检查)
        NSNavPanelExpandedStateForSaveMode = true;  # expand save panel by default(保存文件时的路径选择/文件名输入页)
        NSNavPanelExpandedStateForSaveMode2 = true;
      };

      # The login window shows a specific text as a greeting
      # loginwindow.LoginwindowText = "Welcome";
      # When taking screenshots, store these in a specific folder
      screencapture.location = "~/Pictures/Screenshots";
      # Only ask for a password in the screensaver if it is running for longer than 10 seconds
      screensaver.askForPasswordDelay = 10;
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
    ];
  };
}
