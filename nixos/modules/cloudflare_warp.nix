{ pkgs, ... }:
{
  services.cloudflare-warp.enable = true;
  environment.systemPackages = [ pkgs.cloudflare-warp ];
}
