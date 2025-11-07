{
  description = "Modular NixOS configuration with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # Add flake-parts modules here if needed
      ];
      
      systems = [ "x86_64-linux" ];
      
      flake = {
        nixosConfigurations = {
          mouse = inputs.nixpkgs.lib.nixosSystem {
            
            # Pass inputs to all modules
            specialArgs = { 
              inherit inputs;
              system = "x86_64-linux";
              username = "anoni";
              hostname = "mouse";
            };
            
            modules = [
              # Host-specific config
              ./hosts/mouse/hardware-configuration.nix
              ./hosts/mouse/configuration.nix
              ./hosts/mouse/bootloader.nix
              ./hosts/mouse/dotfiles.nix
              
              # Core modules
              ./modules/core/nixpkgs.nix
              
              # Desktop environment
              ./modules/desktop/display-manager.nix
              ./modules/desktop/hyprland.nix

              # programs - temporary - switch to profiles once stable
              ./modules/programs/zen-browser.nix
              ./modules/programs/starship.nix
              
              # Profile (choose one)
              #./modules/profiles/workstation.nix
            ];
          };
        };
      };
      
      # Development shells
      perSystem = { config, pkgs, ... }: {
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nixpkgs-fmt
              nil
            ];
          };
          
          #rust = import ./shells/rust.nix { inherit pkgs; };
          #web = import ./shells/web.nix { inherit pkgs; };
        };
      };
    };
}
