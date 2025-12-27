{ config, pkgs, ... }:

{
  imports = [
    ../common/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "yuduu-desktop";

  # Gaming-specific configuration for this host.

  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true;
  hardware.xone.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    xpad-noone
    xone
  ];
  boot.kernelModules = [ "xpad-noone" "xone" ];

  environment.systemPackages = with pkgs; [
    heroic
  ];

  system.stateVersion = "25.05";
}
