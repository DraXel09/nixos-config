{ config, pkgs, lib, ... }:
let
  cfg = config.tweaks;

  # Helper para activación condicional
  mkSysIf = lib.mkIf cfg.enable;
in
{
  # --- Opciones bajo namespace propio ---
  options.tweaks = {
    enable = lib.mkEnableOption "system-wide optimizations (graphics, zram, nix)";

    enableZram = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zram swap (compressed RAM swap)";
    };

    enableNixOptimise = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable automatic Nix store optimisation";
    };
  };

  # --- Configuración ---
  config = {

    # Gráficos AMD
    hardware.graphics = mkSysIf {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        #rocmPackages.clr.icd # Para Davinci
      ];
    };

    # Cache de shaders
    environment.variables = mkSysIf {
      MESA_SHADER_CACHE_MAX_SIZE = "6G";
    };

    # Zram Swap — el mkIf interno lo maneja cfg.enableZram
    zramSwap = mkSysIf {
      enable = cfg.enableZram;
      algorithm = "zstd";
      memoryPercent = 30; 
      priority = 5;
    };

    # Optimización Nix Store
    nix = mkSysIf {
      optimise = lib.mkIf cfg.enableNixOptimise {
        automatic = true;
        dates = [ "weekly" ];
      };
      settings = lib.mkIf cfg.enableNixOptimise {
        auto-optimise-store = true;
      };
    };

    # Hora local (solo si dual-boot con Windows)
    # time.hardwareClockInLocalTime = mkSysIf true;
  };
}
