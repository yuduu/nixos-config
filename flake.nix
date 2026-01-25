{
  description = "NixOS configuration for yuduu with home-manager integrated";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Track upstream default branch; pinned by flake.lock and updated via `nix flake update`.
    opencode.url = "github:anomalyco/opencode";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      systems = [ "x86_64-linux" ];
      forAllSystems = lib.genAttrs systems;
      mkNixosHost =
        hostName:
        lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/${hostName}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.yuduu = import ./home/yuduu;
            }
          ];
        };
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              alejandra
              statix
              nil
            ];
          };
        }
      );

      nixosConfigurations = {
        yuduu-desktop = mkNixosHost "yuduu-desktop";
      };
    };
}
