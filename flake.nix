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
            system = "x86_64-linux";
            
            # Pass inputs to all modules
            specialArgs = { 
              inherit inputs;
              username = "anoni";
              hostname = "mouse";
            };
            
            modules = [
              ./hosts/mouse/hardware-configuration.nix
              
              # Host-specific config
              ./hosts/mouse/configuration.nix
              
              # Core modules
              #./modules/core
              
              # Desktop environment
              ./modules/desktop/hyprland.nix
              
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
