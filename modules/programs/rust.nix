{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jetbrains.rust-rover
    
    # Rust toolchain
    cargo
    clippy
    rustfmt
    rust-analyzer
    rustc
    
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
  ];
}
