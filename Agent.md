# Agent Guide for `nixos-config`

- **Purpose**: Enable safe, reproducible changes to hosts and Home Manager with minimal risk.
- **Quick start**: `nix develop` then `alejandra .` then `statix check`, then switch with `./nixos-update`.
- **Layout recap**: `flake.nix` wires hosts + Home Manager; `hosts/common` holds shared desktop defaults; `hosts/<host>/` adds hardware + host-specific bits; `home/yuduu` is the user module; `nixos-update` updates inputs, runs checks, and switches.

## Daily workflow
- Enter the dev shell: `nix develop`.
- Format and lint before switching: `alejandra .` then `statix check`.
- Commit and push every intentional change so hosts stay reproducible and history stays traceable.
- Switch with safety: `./nixos-update` (auto-selects host) or `./nixos-update <host>`; use `--no-update` to skip input bumps during risky changes.
- When adding a host: generate hardware config, set `networking.hostName`, import `../common/desktop.nix`, and register the host in `flake.nix`.

## Editing guidelines
- Do: keep shared bits in `hosts/common`; use `rg` for searching; add short comments only when logic isn’t obvious.
- Avoid: editing generated hardware files; `lib.mkDefault`/`lib.mkForce` unless necessary; secrets in the repo; destructive git commands; global replace without review.
- Stay in ASCII unless the file already uses other characters.

## Validation checklist
- `alejandra .`
- `statix check`
- `nix flake check --keep-going`
- If touching services/boot: run `./nixos-update --no-update` to validate build before updating inputs.
- Post-switch sanity: ensure hostname matches target; verify key services (NetworkManager, GDM/GNOME, PipeWire) start cleanly.

## Troubleshooting tips
- Host auto-select fails: run `./nixos-update <host>` explicitly or set `NIXOS_HOST`.
- Slow builds: consider `nix gc`/`nix store optimise` (already configured to run automatically).
- Zed: use the FHS-wrapped `zed-editor` package already provided so agents work on NixOS.
