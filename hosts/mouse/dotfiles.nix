{
  imports = [ ../../modules/desktop/dotfiles.nix ];
  
  dotfiles = {
    enable = true;
    user = "anoni";
    dotfilesDir = "/home/anoni/.nixos/dotfiles";
    files = [
      { target = ".config/hypr"; source = "hypr"; }
    ];
  };
}
