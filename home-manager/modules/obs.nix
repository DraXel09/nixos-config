{ config, pkgs, lib, ... }:
let
  cfg = config.programs.streaming;
in
{
  # --- Declaración de Opciones ---
  options.programs.streaming = {
    enable = lib.mkEnableOption "Streaming applications for user";    
    enableOBS = lib.mkEnableOption "OBS Studio with plugins";
    enableFonts = lib.mkEnableOption "Streaming-related fonts (Noto, Fira Code, etc.)";
  };

  config = lib.mkIf cfg.enable {
    # --- Fuentes para streaming ---
    # Útiles para overlays, alertas, y diseño gráfico
    home.packages = lib.mkIf cfg.enableFonts (with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
    ]);

    # --- OBS Studio ---
    # Software principal de streaming
    programs.obs-studio = lib.mkIf cfg.enableOBS {
      enable = true;
     # enableVirtualCamera = true; # Requiere v4l2loopback en el sistema
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture        # Captura de juegos Wayland/X11
        obs-move-transition  # Transiciones entre escenas
        obs-vaapi            # Aceleración hardware VAAPI (opcional)
      ];
    };
  };
}