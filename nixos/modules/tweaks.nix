{ config, pkgs, lib, ... }:
{
  # --- Declaración de la opción principal ---
  options.tweaks = {
    enable = lib.mkEnableOption "tweaks/optimizaciones del sistema";
  };

  config = lib.mkIf config.tweaks.enable {

    # Gráficos AMD (32-bit + basic)
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      # extraPackages = with pkgs; [ rocmPackages.clr.icd ];  # descomentar si se necesita Davinci
    };

    # Cache de shaders Mesa (mejora rendimiento gráfico)
    environment.variables.MESA_SHADER_CACHE_MAX_SIZE = "6G";

    # Zram Swap (swap comprimida en RAM)
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 30;
      priority = 5;
    };

    # Optimización automática del store de Nix
    nix = {
      settings = {
        auto-optimise-store = true;
      };
    };

    # Eliminación de generaciones antiguas de Nix
    nix.gc = {
      automatic = true;
      dates = [ "weekly" ];
      options = "--delete-older-than 14d";  # eliminar generaciones
    };

    # Hora local (útil si se tiene dual-boot con Windows)
    # time.hardwareClockInLocalTime = true;

  };
}