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
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  services.xserver = {
    enable = false; # Wir nutzen Wayland, also kein kompletter X-Server
    xkb.layout = "de";
  };



environment.systemPackages = with pkgs; [
  xwayland-satellite
  xwayland # Nötig für die X11-Bibliotheken
];

# Automatisch mit der User-Session starten:
systemd.user.services.xwayland-satellite = {
  description = "Xwayland outside your Wayland compositor";
  wantedBy = [ "graphical-session.target" ];
  serviceConfig = {
    ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite :0";
    Restart = "on-failure";
  };
};
}
