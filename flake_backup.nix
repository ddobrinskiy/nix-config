{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.bat # cat replacement
          pkgs.bottom # top replacement
          pkgs.duf # df replacement
          pkgs.eza # ls replacement
          pkgs.fzf
          pkgs.fzf # fuzzy finder
          pkgs.fzf-zsh
          pkgs.gh # GitHub CLI
          pkgs.mas # Mac App Store CLI
          pkgs.neofetch
          pkgs.uutils-coreutils-noprefix
          pkgs.vim
          pkgs.zsh
        ];


      homebrew = {
        enable = true;
        # onActivation.cleanup = "uninstall";

        taps = [
          "borgbackup/tap"
        ];
        brews = [
          "cowsay"
        ];
        casks = [
          "brave-browser" # Privacy focused browser
          "choosy" # chooser for browser links
          "cursor" # AI code editor
          "google-chrome"
          "iterm2"
          "raycast" # Spotlight replacement
          "telegram"
          "vorta" # BORG backup tool
          "gifox" # GIF recorder
          "shottr" # Screenshot tool
          "zoom" # Video conferencing
        ];
        masApps = {
          "Bitwarden" = 1352778147;
          "Foxray" = 6448898396;
          "Amphetamine" = 937984704;
          "Quick View Calendar" = 1087080039;
          "Be Focused - Pomodoro" = 973134470;
          "WhatsApp Messenger" = 310633997;
        };
      };

      environment.shellAliases = {
        ls = "eza -al";
        top = "btm";
        htop = "btm";
        cat = "bat";
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Enable TouchID Sudo unlock
      security.pam.enableSudoTouchIdAuth = true;

      system.defaults = {
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

      system.activationScripts.postActivation.text = ''
        echo "test" >> /Users/david/Downloads/test.txt
        # Set correct permissions for SSH keys
        echo "Setting SSH private key permissions..."
        chmod 600 /Users/david/.ssh/id_*
        echo "Setting SSH public key permissions..."
        chmod 644 /Users/david/.ssh/id_*.pub
        echo "Setting SSH known_hosts permissions..."
        chmod 644 /Users/david/.ssh/known_hosts

        # Configure VSCode key repeat settings
        # echo "Configuring VSCode key repeat settings..."
        # defaults write Cursor.app ApplePressAndHoldEnabled -bool false
        # defaults delete -g ApplePressAndHoldEnabled
      '';

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Davids-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple".pkgs;
  };
}
