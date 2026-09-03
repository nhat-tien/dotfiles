{ pkgs, nixpkgs-unstable, ...}:
let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
    ] ++ [
      unstable.fcitx5-lotus
      # unstable.fcitx5-qt
    ];
  };

  users.users.uinput_proxy = {
    isSystemUser = true;
    group = "uinput_proxy";
  };

  users.groups.uinput_proxy = {};

  systemd.packages = [ unstable.fcitx5-lotus ];
  systemd.services."fcitx5-lotus-server@nhattien" = {
    wantedBy = [ "multi-user.target" ];
    overrideStrategy = "asDropin";
  };

  #
  # Note for Wezterm:
  #  - Open fcitx5-lotus-settings
  #  - Choose Application
  #  - Choose wezterm
  #  - Choose preedit
  #
}
