{ config, lib, pkgs, ... }:

let
  # Definimos cfg para referenciar las opciones de este módulo fácilmente
  cfg = config.programs.gaming;
in
{
  # Declaramos las opciones para poder activar/desactivar funcionalidades
  options.programs.gaming = {
    enable = lib.mkEnableOption "Gaming support system-wide";
    enableSteam = lib.mkEnableOption "Steam platform";
    enableProtonGE = lib.mkEnableOption "Proton GE compatibility layer";
    enableInputRemapper = lib.mkEnableOption "Input Remapper service";
  };

  config = lib.mkIf cfg.enable {
    # --- Drivers y hardware gaming ---
    hardware = {
      # Habilita soporte general para gráficos (necesario para Vulkan/OpenGL)
      graphics.enable = true;
      steam-hardware.enable = true;
      xone.enable = true;              
      xpadneo.enable = true;           
     # opentabletdriver.enable = true; # Soporte para tabletas gráficas
    };

    # --- Servicios ---
    programs.gamemode.enable = true;
    services.input-remapper.enable = cfg.enableInputRemapper;

    # --- Polkit rules ---
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

    # --- Gamescope ---
    programs.gamescope = {
      enable = true;
      capSysNice = false; # Permite priorización de procesos (problemas con lutris)
    };

    # --- Steam ---
    programs.steam = lib.mkIf cfg.enableSteam {
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

    # --- vkBasalt --- 
    # Instalamos el archivo de configuración del layer Vulkan manualmente
    environment.etc."vulkan/implicit_layer.d/vkBasalt.json".source =
      lib.mkIf (cfg.enable && pkgs.vkbasalt != null)
      "${pkgs.vkbasalt}/share/vulkan/implicit_layer.d/vkBasalt.json";
    
    # Si GOverlay no detecta vkBasalt, ejecutar manualmente:
    # sudo ln -sf ${pkgs.vkbasalt}/lib/libvkbasalt.so /usr/lib/libvkbasalt.so
  };
}
