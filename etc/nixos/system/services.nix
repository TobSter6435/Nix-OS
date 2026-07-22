{ config, pkgs, ... }:

{
 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
   
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; 

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true; 

  
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  services.xserver = {
    enable = false; # Wir nutzen Wayland, also kein kompletter X-Server
    xkb.layout = "de";
  };
}