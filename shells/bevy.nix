{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    # Rust toolchain
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
    rustup

    # Bevy dev: audio / graphics / input / windowing
    alsa-lib
    alsa-lib.dev
    gcc
    libGL
    libxkbcommon
    pkg-config
    udev
    vulkan-loader
    wayland
    wayland-protocols

    # X11 libraries (required for winit on Linux)
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];
  
  shellHook = ''
    export CARGO_TARGET_DIR="$PWD/target"
    
    # Share cargo cache across projects (optional but recommended)
    export CARGO_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}/cargo"
    
    echo "Bevy development environment loaded"
    echo "Cargo target dir: $CARGO_TARGET_DIR"
  '';
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.udev
    pkgs.alsa-lib
    pkgs.vulkan-loader
    pkgs.libGL
    pkgs.libxkbcommon
    pkgs.wayland
    # X11 libraries
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr
  ];
}
