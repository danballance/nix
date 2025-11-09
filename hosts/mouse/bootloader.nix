{ config, pkgs, ... }:
{
  boot = {
    consoleLogLevel = 7;
    initrd.verbose = true;
    kernelParams = [
      #"quiet"
      #"splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
			"snd_intel_dspcfg.dsp_driver=4"
    ];
    loader = {
      efi = {
        canTouchEfiVariables = true;  # don’t rely on NVRAM
        efiSysMountPoint = "/boot";   # FAT32 ESP-NIX
      };
      timeout = 0;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        efiInstallAsRemovable = false;
        gfxmodeEfi = "1024x768";
        configurationLimit = 100;
      };
      systemd-boot = {
        configurationLimit = 100;
      };
    };
  };
}
