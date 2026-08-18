 {...}:
 {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 1000;
    initContent = ''
      source /home/nhattien/dotfiles/zsh/main.zsh
    '';
  };
 }

