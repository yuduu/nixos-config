# Agent Guide for `nixos-config`

- **Purpose**: Keep host and Home Manager configs predictable, safe, and easy to update.
- **Layout recap**: `flake.nix` wires hosts + Home Manager; `hosts/common` holds shared desktop defaults; `hosts/<host>/` adds hardware + host-specific bits; `home/yuduu` is the user module; `nixos-update` updates inputs, runs checks, and switches.

## Daily workflow
- Enter the dev shell: `nix develop`.
- Format and lint before switching: `alejandra .` then `statix check`.
- Commit and push every intentional change so hosts stay reproducible and history stays traceable.
- Switch with safety: `./nixos-update` (auto-selects host) or `./nixos-update <host>`; use `--no-update` to skip input bumps during risky changes.
- When adding a host: generate hardware config, set `networking.hostName`, import `../common/desktop.nix`, and register the host in `flake.nix`.

## Editing guidelines
- Stay in ASCII unless the file already uses other characters.
- Don’t edit generated hardware files except to regenerate them.
- Prefer `lib.mkDefault`/`lib.mkForce` only when necessary; keep shared bits in `hosts/common`.
- Keep secrets out of the repo; use environment variables or external files.
- Comments: only where logic isn’t obvious; keep them short.
- Avoid destructive git commands; the worktree may contain user changes.
- Use `rg` for searching; avoid global replace without review.

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
