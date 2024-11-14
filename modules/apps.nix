{ pkgs, ...}: {

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    bat # cat replacement
    bottom # top replacement
    duf # df replacement
    eza # ls replacement
    fzf
    fzf # fuzzy finder
    fzf-zsh
    gh # GitHub CLI
    git
    mas # Mac App Store CLI
    neofetch
    uutils-coreutils-noprefix
    vim
    zsh
  ];

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    taps = [
      "homebrew/services"
      "borgbackup/tap"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "aria2"  # download tool
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
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
}
