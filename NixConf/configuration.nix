{ config, pkgs, ... }:


{
    imports = [
        ./hardware-configuration.nix

        ./system/core.nix
        ./system/services.nix

        ./applications/dev_packages.nix
        ./applications/everyday_life_packages.nix

        ./desktop/niri.nix
    ];

    system.stateVersion = "24.05";
}
