{ config, pkgs, ... }:
{
  home.username = "nhattien";
  home.homeDirectory = "/home/nhattien";
  home.packages = with pkgs; [
    wezterm
    nerd-fonts.caskaydia-cove
    firefox
    git-credential-manager
    starship
  ];

  programs.git = {
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "nhat-tien";
    extraConfig.credential.credentialStore = "cache";
    extraConfig.pull.rebase = false;
    enable = true;
    userName = "nhat-tien";
    userEmail = "ledangnhattien04@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;
  };


  fonts.fontconfig.enable = true;
  home.stateVersion = "25.05";
}
