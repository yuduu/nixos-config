{ ... }:

{
  imports = [
    ../common/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "yuduu-desktop";

  system.stateVersion = "25.05";
}
