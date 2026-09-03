{ pkgs,... }:
{
  boot = {
    loader.systemd-boot.enable = true;

    loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    # Silent boot
    kernelParams = [
       "quiet"
       "splash"
       "vga=current"
       "rd.systemd.show_status=false"
       "rd.udev.log_level=3"
       "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;

  };

}
