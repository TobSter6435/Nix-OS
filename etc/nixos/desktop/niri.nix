{ config, pkgs, ... }:

{
  programs.niri.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    niri
  ];
}