{ helper, ... }:

{
  imports = (helper.collectNixFiles ./programs) ++ [
    ./packages.nix
    ./lsp.nix
  ];

  wayland.windowManager.hyprland.systemd.enable = false;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.username = "nhattien";
  home.homeDirectory = "/home/nhattien";
  home.stateVersion = "26.05";

}
