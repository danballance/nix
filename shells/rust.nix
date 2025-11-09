{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
  ];
  
  shellHook = ''
    echo "Rust development environment loaded"
  '';
}
