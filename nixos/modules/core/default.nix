{ pkgs, ...}:

{

  imports = [
     ./boot.nix
     ./network.nix
     ./nixos.nix
     ./system_packages.nix
  ];


  hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
  };

  services.power-profiles-daemon.enable = true;

  services.upower.enable = true;

  programs.zsh.enable = true;

  programs.ssh.startAgent = true;

  services.gnome.gcr-ssh-agent.enable = false;

  environment.shells = [ pkgs.zsh ];

  users.defaultUserShell = pkgs.zsh;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire
  programs.dconf.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."nhattien" = {
    isNormalUser = true;
    description = "nhattien";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [
      #  thunderbird
    # ];
  };

  programs.firefox.enable = true;

  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Chắc để cải thiện tốc độ graphic
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
       intel-media-driver
    ];
  };

  system.stateVersion = "26.05";
}
