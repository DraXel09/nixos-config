{ config, lib, pkgs, ... }:

let 
  cfg = config.gamingHome;
in 
{
  # --- Declaración de Opciones ---
  options.gamingHome = {
    enable = lib.mkEnableOption "Configuración personalizada para gaming";
  };

  config = lib.mkIf cfg.enable {
    # Paquetes y Programas para Gaming
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
     wineWow64Packages.staging           # Wine con soporte 64/32 bits
     winetricks 
     protonplus

     # Emuladores
     ryubing
     cemu

     # Herramientas de Diagnóstico
     mesa-demos  
     vulkan-tools 
    
     # Overlay y Redimiento
     mangohud 
     goverlay 
     vkbasalt 

     # Hardware Gaming 
     joystickwake      # Despierta el sistema al conectar un mando
     #input-remapper   # Reasigna botones de mando (GUI)
   ];

   home.sessionVariables = {
     # Ruta adicional para herramientas de compatibilidad de Steam (Proton custom)
     STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
   };
  };
}
