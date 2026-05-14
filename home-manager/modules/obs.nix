{ config, pkgs, lib, ... }:
let 
  cfg = config.streaming;
in 
{
  # --- Declaración de Opciones ---
  options.streaming = {
    enable = lib.mkEnableOption "OBS Studio y plugins";    
  };

  config = lib.mkIf cfg.enable {
    # --- Fuentes ---
    home.packages = lib.mkIf cfg.enable (with pkgs; [
      fira-code
      fira-code-symbols
      atkinson-hyperlegible
    ]);

    # --- OBS Studio ---
    programs.obs-studio = lib.mkIf cfg.enable {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture        # Captura de juegos Wayland/X11
        obs-move-transition  # Transiciones entre escenas
        obs-vaapi            # Aceleración hardware VAAPI (opcional)
      ];
    };
  };
}