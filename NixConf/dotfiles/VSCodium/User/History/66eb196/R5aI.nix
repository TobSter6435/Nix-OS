{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    pkg-config
    glib
    gtk3
    webkitgtk_4_1
    openssl
    glib-networking
    nodejs
    cargo
    cargo-tauri
    rustc
  ];

  shellHook = ''
    echo "Tauri dev environment loaded! Run 'cargo tauri dev' to start."
  '';
}