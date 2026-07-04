{ config, lib, ... }:

let 
  cfg = config.tweaks;
in 
{
  options.tweaks = {
    enable = lib.mkEnableOption "tweaks/optimizaciones del sistema";
  };  

  config = lib.mkIf cfg.enable {

    # Cache de shaders Mesa
    environment.variables.MESA_SHADER_CACHE_MAX_SIZE = "6G";

    # Zram Swap
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 30;
      priority = 100;
    };
    systemd.oomd.enable = true;

    # Optimización automática del store de Nix
    nix = {
      settings = {
        auto-optimise-store = true;
      };
    };

    # Cache binaria de Nix
    nix.settings = {
      substituters = [ 
        "https://cache.nixos.org"
        "https://nix-community.cachix.org" 
      ];
      trusted-public-keys = [
         "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
         "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    # Eliminación de generaciones antiguas de Nix
    nix.gc = {
      automatic = true;
      dates = [ "weekly" ];
      options = "--delete-older-than 7d";  # eliminar generaciones 
    };

    # Hora local (útil si se tiene dual-boot con Windows)
    # time.hardwareClockInLocalTime = true;

  };
}