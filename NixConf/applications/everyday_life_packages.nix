{ config, pkgs, ... }:

{

  services.openssh.enable = true;

  services.tailscale.enable = true;

  boot.kernelModules = [ "wireguard" ];

  

  programs.steam = {

    enable = true;

    remotePlay.openFirewall = true;

    dedicatedServer.openFirewall = true;

  };



  programs.gpu-screen-recorder.enable = true;

  programs.fish.enable = true;

  services.mullvad-vpn.enable = true;

  services.flatpak.enable = true;



  environment.systemPackages = with pkgs; [
    mullvad-browser
    mullvad-vpn
    vesktop
    kitty
    wine
    starship
    btop
    pavucontrol
    nautilus
    polkit_gnome
    fastfetch
    fuzzel
    prismlauncher
    proton-pass
    grim
    slurp
    wl-clipboard
    xwayland-satellite
    cava
    tty-clock
    mapscii
    pipes
    gpu-screen-recorder-gtk
    keepassxc
    tailscale
    localsend
    jan
  ];

}
