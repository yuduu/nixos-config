{ ... }:

{
  imports = [ ];

  # Placeholder hardware config for yuduu-desktop.
  # Replace with the output of `nixos-generate-config --show-hardware-config`
  # from the target machine before the first build.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
