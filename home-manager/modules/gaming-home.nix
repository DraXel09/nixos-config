{ config, lib, pkgs, ... }:

let 
  cfg = config.gamingHome;
in 
{
  options.gamingHome = {
    enable = lib.mkEnableOption "Configuración personalizada para gaming";
  };

  config = lib.mkIf cfg.enable {
    
    home.packages = with pkgs; [
     # Lanzadores y Compatibilidad
    (lutris.override {
      extraLibraries = p: [ p.libadwaita p.gtk4 ];
      buildFHSEnv = args: pkgs.buildFHSEnv (args // {
        multiPkgs = envPkgs:
          let
            originalPkgs = args.multiPkgs envPkgs;
            customLdap = envPkgs.openldap.overrideAttrs (_: { doCheck = false; });
          in
          builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
      });
    })
     umu-launcher
     faugus-launcher
     winetricks 
     protonplus
     protontricks

     # Emuladores
     ryubing
     cemu
     eden

     # Herramientas de Diagnóstico
     mesa-demos  
     vulkan-tools 
    
     # Overlay y Redimiento
     mangohud 
     goverlay 
     vkbasalt
     lsfg-vk-ui 
     lsfg-vk

     # Hardware Gaming
     joystickwake   
     #input-remapper   # Reasigna botones de mando (GUI)
   ];

   home.sessionVariables = {
     # Ruta adicional para herramientas de compatibilidad de Steam (Proton custom)
     STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
   };
  };
}
