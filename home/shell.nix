{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin"
      export PATH="$PATH:$HOME/.local/bin"
      export PATH="$PATH:$HOME/micromamba/envs/py312/bin"
    '';
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "fzf-zsh-plugin"
        "zsh-syntax-highlighting"
        "python"
        "man"
      ];
      custom = "$HOME/.oh-my-zsh/custom";
    };
  };

  home.shellAliases = {
    df = "duf";
    htop = "btm";
    ls = "eza -al";
    top = "btm";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };


}
