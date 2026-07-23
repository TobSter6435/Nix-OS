{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  programs.fish.enable = true;
  services.mullvad-vpn.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
  ];

  environment.systemPackages = with pkgs; [
    mullvad-browser
    mullvad-vpn
    vesktop
    kitty
    starship
    btop
    pavucontrol
    nautilus
    polkit_gnome
    fastfetch
  ];
}
