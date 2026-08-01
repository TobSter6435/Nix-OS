{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    pkg-config
    cargo
    rustc
    cargo-tauri
  ];

  buildInputs = with pkgs; [
    glib
    gtk3
    libsoup_3
    webkitgtk_4_1
    openssl
    cairo
    pango
    atk
    gdk-pixbuf
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath (with pkgs; [
      openssl
      glib
      gtk3
      webkitgtk_4_1
      libsoup_3
    ])}:$LD_LIBRARY_PATH
  '';
}