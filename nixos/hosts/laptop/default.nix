{...}:
{
   imports = [
       ./hardware-configuration.nix

       ../../modules/core
       ../../modules/desktop/hyprland.nix
       ../../modules/development
       ../../modules/viet_key

       ../../modules/cloudflare_warp.nix

       # Services
       ../../modules/services/navidrome.nix
   ];
}
