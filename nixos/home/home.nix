{ helper, ... }:

{
  imports = (helper.collectNixFiles ./programs) ++
    [
      ./packages.nix
      ./lsp.nix
    ];



  wayland.windowManager.hyprland.systemd.enable = false;

  home.username = "nhattien";
  home.homeDirectory = "/home/nhattien";
  home.stateVersion = "26.05";
}
