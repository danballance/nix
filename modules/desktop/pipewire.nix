{pkgs, ...}:
{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  
  hardware.enableRedistributableFirmware = true;
  hardware.firmwareCompression = "none";
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}

