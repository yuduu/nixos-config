# nixos-config

NixOS + home-manager configuration for `yuduu`, managed as a flake.

## Layout

- `hosts/common`: shared desktop defaults (GNOME, user, base packages).
- `hosts/lenovo-laptop`: laptop-specific system configuration (imports generated hardware info).
- `hosts/yuduu-desktop`: workstation system configuration (replace `hardware-configuration.nix` with generated hardware info).
- `home/yuduu`: Home Manager module for the `yuduu` user.
- `nixos-update`: helper script that updates inputs, runs sanity checks, and switches the host.

## Usage

Format and lint the flake via the dev shell:

```bash
nix develop
alejandra .
statix check
```

Update and switch the system with the helper script. It auto-detects the matching `nixosConfiguration`, but you can override it:

```bash
./nixos-update            # auto-detect via networking.hostName
./nixos-update lenovo-laptop
./nixos-update yuduu-desktop
```

### Preparing a new host

Use this flow when bringing up another machine (e.g. `yuduu-desktop`):

1) Boot the NixOS installer ISO, get networking, and install git: `nix-shell -p git`.
2) Clone the repo: `git clone https://…/nixos-config.git && cd nixos-config`.
3) Generate hardware info for that host: `sudo nixos-generate-config --show-hardware-config > hosts/yuduu-desktop/hardware-configuration.nix` (adjust path if adding another host).
4) Install the system: `sudo nixos-install --flake .#yuduu-desktop`.
5) Reboot into the new system and update/switch as usual: `./nixos-update yuduu-desktop`.

If you add more hosts, create `hosts/<new-host>/` with a `hardware-configuration.nix`, set `networking.hostName` in `default.nix`, and reuse `hosts/common/desktop.nix` where appropriate.
