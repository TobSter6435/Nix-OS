{ config, pkgs, ... }:

{

#ADD YOU PYTHON STUFF HERE(and hopefully it works)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    glib
  ];

  environment.systemPackages = with pkgs; [
    git
    uv
    gh

    vscodium

    nil
    nixpkgs-fmt

    gcc
    gnumake
    ripgrep
    fzf
    jq
    bat

    python3 
    
    rustc
    cargo 

    pkg-config
    openssl.dev
    gtk3.dev
    webkitgtk_4_1.dev
    libsoup_3.dev
    glib.dev
    cargo-tauri
  ]; 
}
