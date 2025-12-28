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
  boot.blacklistedKernelModules = [ "xpad" ];

  # Keep the Xbox 360 wireless receiver out of USB autosuspend.
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="0719", TEST=="power/control", ATTR{power/control}="on"
  '';

  environment.systemPackages = with pkgs; [
    heroic
  ];

  environment.etc = {
    "xdg/autostart/steam.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Steam
      Exec=steam -silent
      X-GNOME-Autostart-enabled=true
    '';
    "xdg/autostart/heroic.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Heroic
      Exec=heroic
      X-GNOME-Autostart-enabled=true
    '';
  };

  system.stateVersion = "25.05";
}
