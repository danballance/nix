{ config, lib, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  
  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    ghostty
    mako
    hyprpaper
    waybar
    grim
    slurp
    wl-clipboard
  ];
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Hint Electron apps to use Wayland
    WLR_NO_HARDWARE_CURSORS = "1";  # Fix cursor issues
  };
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
