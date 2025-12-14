{ lib, pkgs, ... }:

{
  imports = [
    ../common/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "lenovo-laptop";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.powertop.enable = true;

  services.thermald.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
}
