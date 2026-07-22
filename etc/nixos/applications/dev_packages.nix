{ config, pkgs, ... }:

{
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
    rustup

  ]; 
}