{
  description = "Mi configuración de NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    eden.url = "github:daaboulex/eden-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, eden, ... }: {
  # El nombre 'nixos' aquí define lo que usas en el comando --flake .#nixos
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pasamos variables clave para no hardcodearlas en los módulos
      specialArgs = {
        username = "joellyb";
        hostname = "nixos";
        inherit eden;
      };

      modules = [
        ./nixos/configuration.nix

        nixos-hardware.nixosModules.lenovo-ideapad-15alc6
        home-manager.nixosModules.home-manager
        eden.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { username = "joellyb"; };
          home-manager.users.joellyb = import ./home-manager/home.nix;
        }
      ];
    };
  };
}
