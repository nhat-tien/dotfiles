{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gdb
    file

    # xdg-desktop-portal-hyprland
    # xdg-desktop-portal
    brightnessctl
    # libva-utils
    pulseaudio
    pipewire
    wireplumber
    upower
    nftables

    easyeffects
  ];
}
