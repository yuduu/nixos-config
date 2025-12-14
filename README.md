# nixos-flake

NixOS + home-manager configuration for `yuduu`, managed as a flake.

## Layout

- `hosts/lenovo-laptop`: host-specific system configuration (imports generated hardware info).
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
```
