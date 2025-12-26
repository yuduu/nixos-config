{ pkgs, ... }:

{
  imports = [
    ../common/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "yuduu-desktop";

  # Gaming-specific configuration for this host.
  boot.kernelModules = [ "xpad" ];

  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    heroic
  ];

  system.stateVersion = "25.05";
}
