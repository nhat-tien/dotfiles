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
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-qt
    ] ++ [
      unstable.fcitx5-lotus
    ];
  };

  systemd.packages = [ pkgs.fcitx5-lotus ];
  systemd.services."fcitx5-lotus-server@nhattien" = {
    wantedBy = [ "multi-user.target" ];
    overrideStrategy = "asDropin";
  };
}
