{ pkgs, ...}:
{
  services.displayManager.ly.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland
    swaynotificationcenter
  ];
}
