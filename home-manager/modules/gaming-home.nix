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
     qt6Packages.libqtpas
     goverlay 
     vkbasalt
     lsfg-vk-ui 
     lsfg-vk

     # Hardware Gaming
     joystickwake   
   ];

   home.sessionVariables = {
     # Ruta adicional para herramientas de compatibilidad de Steam (Proton custom)
     STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
   };
  };
}
