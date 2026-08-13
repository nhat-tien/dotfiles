{ ... }:
{
  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };

    systemd.enable = true;
  };
}
