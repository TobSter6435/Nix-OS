# /etc/nixos/desktop/shell.nix
{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      notifications.enable_daemon = true;
      # weitere Optionen hier, sobald du sie aus deinem alten
      # mako/config bzw. deinen Wünschen übernommen hast
    };
  };

  home.stateVersion = "25.05"; # an deine NixOS-Version anpassen

  # mako-Paket + dessen Service-Config hier rausnehmen, sobald
  # Noctalia-Notifications bei dir laufen
}