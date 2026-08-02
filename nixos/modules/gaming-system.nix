{ config, lib, pkgs, ... }:

let
  cfg = config.programs.gaming;
in
{
  options.programs.gaming = {
    enable = lib.mkEnableOption "Gaming support system-wide";
  };

  config = lib.mkIf cfg.enable {

    # Hardware gaming 
    hardware = {
      steam-hardware.enable = true;          
    };

    # Servicios
    programs.gamemode = {
      enable = true;
      enableRenice = true;
    };
    programs.gamescope = {
      enable = true;
      enableWsi = true;
      capSysNice = false; # Permite priorización de procesos (problemas con lanzadores)
    };

    # Steam
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          TZ = ":/etc/localtime";
          OBS_VKCAPTURE = "1";
        };
      };
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };

    # Input Remapper
    services.input-remapper.enable = true;

    # VkBasalt
    # Instalamos el archivo de configuración del layer Vulkan manualmente
    environment.etc."vulkan/implicit_layer.d/vkBasalt.json".source =
      lib.mkIf (cfg.enable && pkgs.vkbasalt != null)
      "${pkgs.vkbasalt}/share/vulkan/implicit_layer.d/vkBasalt.json";
  };
}
