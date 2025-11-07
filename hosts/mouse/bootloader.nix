{ config, pkgs, ... }:
{
  boot.loader.efi.canTouchEfiVariables = true;    # don’t rely on NVRAM
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiInstallAsRemovable = false;
  boot.loader.efi.efiSysMountPoint = "/boot";  # FAT32 ESP-NIX
}
