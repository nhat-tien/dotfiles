{ config, helper, pkgs, inputs, ... }:

{
  imports =
    # Programs
    (helper.collectNixFiles ./programs)
    ++ [ ./packages.nix ];


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


  wayland.windowManager.hyprland.systemd.enable = false;

  home.username = "nhattien";
  home.homeDirectory = "/home/nhattien";
  home.stateVersion = "26.05";
}
