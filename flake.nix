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
              ./modules/desktop/graphics.nix
              ./modules/desktop/hyprland.nix
              ./modules/desktop/login.nix
              ./modules/desktop/nerd-fonts.nix
              ./modules/desktop/pipewire.nix
              ./modules/desktop/pixelbook-avs.nix

              # programs
              ./modules/programs/cli.nix
              ./modules/programs/communication.nix
              ./modules/programs/dev-tools.nix
              ./modules/programs/starship.nix
              ./modules/programs/system.nix
              ./modules/programs/zen-browser.nix
              
            ];
          };
        };
      };
      
      # Development shells
      perSystem = { config, system, pkgs, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nixpkgs-fmt
              nil
            ];
          };
          
          rust = import ./shells/rust.nix { inherit pkgs; };
          bevy = import ./shells/bevy.nix { inherit pkgs; };
        };
      };
    };
}
