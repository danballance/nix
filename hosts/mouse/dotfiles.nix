{ pkgs, ... }:
let
  currentTheme = "catppuccin";
in {
  imports = [ ../../modules/desktop/dotfiles.nix ];
  dotfiles = {
    enable = true;
    user = "anoni";
    dotfilesDir = "/home/anoni/.nixos/dotfiles";
    files = [
      { target = ".config/hypr"; source = "hypr"; }
      { target = ".config/waybar"; source = "waybar"; }
      { target = ".vimrc"; source = ".vimrc"; }
      { target = ".config/theme"; source = "omarchy-themes/${currentTheme}"; }
    ];
  };
}
