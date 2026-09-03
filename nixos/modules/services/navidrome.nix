{ pkgs, lib, ... }:
{

  environment.systemPackages = with pkgs; [
    navidrome # selfhost music server
  ];

  users.groups.navidrome_music = {};

  users.users.nhattien.extraGroups = [
    "navidrome_music"
  ];

  users.users.navidrome.extraGroups = [
    "music"
  ];

  systemd.tmpfiles.rules = [
    "d /srv/navidrome 2775 nhattien navidrome_music -"
  ];

  services.navidrome = {
    enable = true;
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = "/srv/navidrome/SelfHostMusic/";
      DataFolder = "/var/lib/navidrome";
      LogLevel = "ERROR";
    };
  };

  # This for inactive services, I will start when I need it
  systemd.services.navidrome.wantedBy = lib.mkForce [];

  networking.firewall.allowedTCPPorts = [ 4533 ]; # Mở cổng 4533 cho Navidrome
}
