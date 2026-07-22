{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      nixconf   = "sudo nano /etc/nixos/configuration.nix";
      hwconf    = "sudo nano /etc/nixos/hardware-configuration.nix";
      coreconf  = "sudo nano /etc/nixos/system/core.nix";
      servconf  = "sudo nano /etc/nixos/system/services.nix";
      devconf   = "sudo nano /etc/nixos/applications/dev_packages.nix";
      appsconf  = "sudo nano /etc/nixos/applications/everyday_life_packages.nix";
      niriconf  = "sudo nano /etc/nixos/desktop/niri.nix";
      shellconf = "sudo nano /etc/nixos/desktop/shell.nix";
      fishconf  = "sudo nano /etc/nixos/desktop/fish.nix";

      nrs  = "sudo nixos-rebuild switch";
      nrb  = "sudo nixos-rebuild boot";
      nrt  = "sudo nixos-rebuild test";
      nrc  = "sudo nixos-rebuild switch";

      nchu = "sudo nix-channel --update";
      ngc  = "sudo nix-collect-garbage -d";
      nsearch = "nix search nixpkgs";

      ll = "ls -lah";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };
    interactiveShellInit = ''
      set -g fish_greeting
      function mkcd
          mkdir -p $argv[1] && cd $argv[1]
      end
    '';
  };
}