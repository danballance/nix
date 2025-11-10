{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
		aseprite
    claude-code
		gimp3-with-plugins
    gitkraken
		#jetbrains.datagrip
		#jetbrains.pycharm-professional
		#jetbrains.rust-rover
    zed-editor-fhs
  ];
}
