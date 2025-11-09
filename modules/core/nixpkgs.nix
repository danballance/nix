{ ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.direnv.enable = true;
  programs.nix-ld.enable = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 500000000; # 500 MB
    substituters = [
      "https://cache.nixos.org" # Default
      "https://claude-code.cachix.org"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # Default NixOS
      "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk=" # Claude Code
      "nix-devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" # Nix Community
      "community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
