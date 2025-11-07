{ config, lib, ... }:
let
  cfg = config.dotfiles;
in
{
  options.dotfiles = {
    enable = lib.mkEnableOption "dotfile symlink management";
    
    user = lib.mkOption {
      type = lib.types.str;
      description = "Username for dotfile management";
      example = "dan";
    };
    
    dotfilesDir = lib.mkOption {
      type = lib.types.str;
      description = "Absolute path to dotfiles directory";
      example = "/home/dan/nix-config/dotfiles";
    };
    
    files = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          target = lib.mkOption {
            type = lib.types.str;
            description = "Target path relative to home directory";
            example = ".config/hypr";
          };
          source = lib.mkOption {
            type = lib.types.str;
            description = "Source path relative to dotfilesDir";
            example = "hypr";
          };
        };
      });
      default = [];
      description = "List of dotfiles to symlink";
    };
  };
  
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = map (df:
      "L+ /home/${cfg.user}/${df.target} - ${cfg.user} users - ${cfg.dotfilesDir}/${df.source}"
    ) cfg.files;
  };
}
