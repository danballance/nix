{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brave
    discord
    obsidian
		obs-studio
    proton-pass
    protonmail-desktop
    protonvpn-gui
    remmina
  ];
}
