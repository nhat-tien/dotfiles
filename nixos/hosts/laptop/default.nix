{...}:
{
   imports = [
       ./hardware-configuration.nix

       ../../modules/core

       ../../modules/desktop/hyprland.nix
       ../../modules/development
       ../../modules/vietkey.nix
       ../../modules/cloudflare_warp.nix

       # Services
       ../../modules/services/navidrome.nix
   ];
}
