{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Lanzadores y Compatibilidad ---
    (lutris.override {
    extraLibraries = p: [ p.libadwaita p.gtk4 ];
    })
    umu-launcher
    faugus-launcher
    wineWow64Packages.staging # Wine con soporte 64/32 bits
    winetricks 
    protonplus

    # --- Emuladores ---
    ryubing

    # --- Herramientas de Diagnóstico ---
    mesa-demos   # Utilidades de diagnóstico Mesa
    vulkan-tools # Herramientas de diagnóstico Vulkan
    
    # --- Overlay y Redimiento ---
    mangohud 
    goverlay 
    vkbasalt 

    # --- Hardware Gaming ---
    joystickwake      # Mantiene el joystick despierto
    #input-remapper   # opcional si quieres solo binarios (GUI cliente)
  ];

  home.sessionVariables = {
    # Ruta adicional para herramientas de compatibilidad de Steam (Proton custom)
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.home.homeDirectory}/.steam/root/compatibilitytools.d";
  };
}
