{ ... }:

{
  imports = [
    ../common/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "yuduu-desktop";
}
