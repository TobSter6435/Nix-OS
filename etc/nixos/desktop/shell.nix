{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    quickshell
    noctalia-shell
  ];
}