{ config, pkgs, ... }:

{
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "TobSter"; 
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  
  
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  networking.firewall.checkReversePath = "loose";
  services.resolved.enable = true;

  console.keyMap = "de";

  boot.kernelParams = [
    "panic=15"
  ];  
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  

  nixpkgs.config.allowUnfree = true;
  
  services.xserver.videoDrivers = [ "nvidia" ] ;
  hardware.graphics = {
    enable=true;
};

 hardware.nvidia = {

   modesetting.enable = true;
   powerManagement.enable = false;
   powerManagement.finegrained  = false;
   open = true;
   nvidiaSettings = true;
   package = config.boot.kernelPackages.nvidiaPackages.stable;


};
  

  programs.xwayland.enable = true;
  
  users.users.NixOS = {
    isNormalUser = true;
    description = "TobSter";
    extraGroups = ["audio" "networkmanager" "wheel" "video" "input" ]; 
  };


  programs.appimage = {
  enable = true;
  binfmt = true; 
};

networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 22 53317 ];
  allowedUDPPorts = [ 53317 ];
  allowPing = true;

};

}

