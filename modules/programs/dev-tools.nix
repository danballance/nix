{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
		aseprite
    claude-code
		gimp3-with-plugins
    gitkraken
    inputs.frosty-vim.packages.${pkgs.system}.default
    zed-editor-fhs
  ];
}
