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
    chafa # show images in terminal
    duf # df replacement
    exiftool # show metadata of images
    eza # ls replacement
    fzf # fuzzy finder
    fzf-zsh # fzf wrapper for oh-my-zsh
    gh # GitHub CLI
    git
    just # use Justfile to simplify nix-darwin's commands 
    lazygit # git tui
    lesspipe # better pipe support for less
    mas # Mac App Store CLI
    neofetch
    neovim
    uutils-coreutils-noprefix
    vim
    zsh
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
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
      "datagrip" # JetBrains DataGrip
      "gifox" # GIF recorder
      "google-chrome"
      "iina" # video player
      "iterm2"
      "raycast" # Spotlight replacement
      "shottr" # Screenshot tool
      "telegram"
      "vorta" # BORG backup tool
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
