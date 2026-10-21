{
  description = "Mi configuración de NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    pixie-sddm.url = "github:xCaptaiN09/pixie-sddm";
    bedrock-on-linux = {
      url = "github:Wyze3306/BedrockOnLinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lsfg-vk = {
      url = "github:Daaboulex/lsfg-vk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darkmatter-grub-theme = {
      url = "gitlab:VandalByte/darkmatter-grub-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, chaotic,home-manager, nixos-hardware, pixie-sddm, darkmatter-grub-theme, lsfg-vk, bedrock-on-linux, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # Pasamos variables clave para no hardcodearlas en los módulos
      specialArgs = {
        username = "joellyb";
        hostname = "nixos";
        inherit inputs;
      };
      modules = [
        ./nixos/configuration.nix
        {
          environment.systemPackages = [
            bedrock-on-linux.packages.x86_64-linux.default
          ];
        }
        chaotic.nixosModules.default
        darkmatter-grub-theme.nixosModule
        nixos-hardware.nixosModules.lenovo-ideapad-15alc6
        home-manager.nixosModules.home-manager
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
