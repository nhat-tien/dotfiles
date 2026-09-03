{ helper, ... }:
{
  imports = (helper.collectNixFiles ./programs) ++ [
    ./home_packages.nix
    ./lsp.nix
  ];

  wayland.windowManager.hyprland.systemd.enable = false;


  # Set darktheme
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.username = "nhattien";
  home.homeDirectory = "/home/nhattien";
  home.stateVersion = "26.05";

}
