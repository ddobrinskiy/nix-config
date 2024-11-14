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

      # macOS dock does not hide automatically
      dock.autohide = false;
      # Don't rearrange spaces based on the most recent use
      dock.mru-spaces = false;
      # Finder shows all file extensions
      finder.AppleShowAllExtensions = true;
      # Default Finder folder view is the columns view
      finder.FXPreferredViewStyle = "clmv";
      # The login window shows a specific text as a greeting
      # loginwindow.LoginwindowText = "Welcome";
      # When taking screenshots, store these in a specific folder
      screencapture.location = "~/Pictures/Screenshots";
      # Only ask for a password in the screensaver if it is running for longer than 10 seconds
      screensaver.askForPasswordDelay = 10;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

}
