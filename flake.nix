{
  description = "Mi configuración de NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    pixie-sddm.url = "github:xCaptaiN09/pixie-sddm";
    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eden = {
      url = "github:daaboulex/eden-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, eden, pixie-sddm, darkmatter-grub-theme, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pasamos variables clave para no hardcodearlas en los módulos
      specialArgs = {
        username = "joellyb";
        hostname = "nixos";
        inherit eden inputs;
      };

      modules = [
        ./nixos/configuration.nix
        darkmatter-grub-theme.nixosModule
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
