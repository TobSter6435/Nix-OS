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

    # Für PyTorch / C++ Binaries
    stdenv.cc.cc.lib
    zlib
  ];

  shellHook = ''
    # 1. Standard Bibliotheks-Pfade mappen
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath (with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      glib
      gtk3
      webkitgtk_4_1
      libsoup_3
    ])}:$LD_LIBRARY_PATH"

    # 2. DER BRECHHAMMER: Zwingt Linux dazu, libstdc++ sofort zu laden!
    export LD_PRELOAD="${pkgs.stdenv.cc.cc.lib}/lib/libstdc++.so.6"

    echo "NixOS Environment bereit! (Python 3.12 + LD_PRELOAD aktiv)"
  '';
}