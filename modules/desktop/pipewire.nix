{pkgs, ...}:
{
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  
  hardware.enableRedistributableFirmware = true;
  hardware.firmwareCompression = "none";
  
  #environment.systemPackages = with pkgs; [
  #  pavucontrol
  #];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}

