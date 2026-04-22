{ config, lib, pkgs, ... }:

let
  cfg = config.programs.gaming;
in
{
  # --- Declaración de Opciones ---
  options.programs.gaming = {
    enable = lib.mkEnableOption "Gaming support system-wide";
    enableProtonGE = lib.mkEnableOption "Proton GE compatibility layer";
    enableInputRemapper = lib.mkEnableOption "Input Remapper service";
  };

  config = lib.mkIf cfg.enable {

    # Hardware gaming 
    hardware = {
      steam-hardware.enable = true; 
      xone.enable = true;              
      xpadneo.enable = true;           
    };

    # Servicios
    programs.gamemode.enable = true; 
    programs.gamescope = {
      enable = true;
      capSysNice = false; # Permite priorización de procesos (problemas con lutris)
    };

    # Steam
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      package = pkgs.steam.override {
        extraEnv = {
          TZ = ":/etc/localtime";
          OBS_VKCAPTURE = "1";
        };
      };
      # Añade Proton GE solo si la opción está activada
      extraCompatPackages = lib.optionals cfg.enableProtonGE [ pkgs.proton-ge-bin ];
    };

    # Input Remapper
    services.input-remapper.enable = cfg.enableInputRemapper;  
    # Permite a los usuarios usar input-remapper sin contraseña
    security.polkit.extraConfig = lib.mkIf cfg.enableInputRemapper ''
      polkit.addRule(function(action, subject) {
        if (action.id == "inputremapper" && subject.isInGroup("users")) {
          return polkit.Result.YES;
        }
        if (action.id == "org.freedesktop.policykit.exec" &&
            action.lookup("program")?.indexOf("input-remapper") !== -1 &&
            subject.isInGroup("users")) {
          return polkit.Result.YES;
        }
      });
    '';

    # VkBasalt
    # Instalamos el archivo de configuración del layer Vulkan manualmente
    environment.etc."vulkan/implicit_layer.d/vkBasalt.json".source =
      lib.mkIf (cfg.enable && pkgs.vkbasalt != null)
      "${pkgs.vkbasalt}/share/vulkan/implicit_layer.d/vkBasalt.json";
    # Si GOverlay no detecta vkBasalt, ejecutar manualmente:
    # sudo ln -sf ${pkgs.vkbasalt}/lib/libvkbasalt.so /usr/lib/libvkbasalt.so
  };
}
