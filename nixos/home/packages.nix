{ pkgs, ... }:

{

  home.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    zip
    xz
    unzip
    p7zip

    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    fzf # A command-line fuzzy finder

    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility

    nix-output-monitor

    hugo # static site generator

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    neovim
    git-credential-manager

    google-chrome
    wezterm
    kitty
    yazi
    zellij

    lazygit
    nautilus
    blueman

    # rustdesk-flutter

    hyprpaper
    hyprlauncher
    hyprlock
    hypridle
    waybar
    wofi

    sunshine
    obsidian

    # quickshell
    # qt6.qt5compat
    # kdePackages.qt5compat
    # kdePackages.qtpositioning

    # qt6Packages.qt5compat
    # libsForQt5.qt5.qtgraphicaleffects
    # qt5.qtwayland

    # noisetorch # Mic Noise Reduce
    imagemagick

    ffmpeg
    easytag # Edit tag metadata for mp3 file
    wrangler # Cloudflare CLI
    yt-dlp


    obs-studio

    woff2 #Compress font to web
  ];

}
