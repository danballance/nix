{ pkgs, lib, ... }:

let
  # Package the Chromebook-specific AVS firmware
  chromebook-avs-firmware = pkgs.stdenvNoCC.mkDerivation {
    name = "chromebook-avs-firmware";
    version = "2024.02";

    src = ../../firmware;

    installPhase = ''
      mkdir -p $out/lib/firmware/intel
      cp -r intel/avs $out/lib/firmware/intel/
    '';

    meta = with lib; {
      description = "Chromebook-specific AVS audio topology firmware";
      license = licenses.unfreeRedistributable;
    };
  };
in
{
  # Add Chromebook AVS firmware to the system
  hardware.firmware = [ chromebook-avs-firmware ];

  # Configure AVS kernel module options
  boot.extraModprobeConfig = ''
    options snd-soc-avs ignore_fw_version=1
    options snd-soc-avs obsolete_card_names=1
  '';
}
