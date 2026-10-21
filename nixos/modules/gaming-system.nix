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
    boot.kernelModules = [ "ntsync" ];
    environment.systemPackages = with pkgs; [
      low-latency-layer
    ];

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

    # Firewall
    networking.firewall = {
      allowedUDPPorts = [ 19132 19133 7551 5555 ];
    };

    boot.kernel.sysctl = {
     "net.ipv6.conf.wlp1s0.disable_ipv6" = 1;
    };
    
    # VkBasalt
    # Instalamos el archivo de configuración del layer Vulkan manualmente
    environment.etc."vulkan/implicit_layer.d/vkBasalt.json".source =
      lib.mkIf (cfg.enable && pkgs.vkbasalt != null)
      "${pkgs.vkbasalt}/share/vulkan/implicit_layer.d/vkBasalt.json";
  };
}
