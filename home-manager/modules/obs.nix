{ config, pkgs, lib, ... }:
let 
  cfg = config.streaming;
in 
{
  options.streaming = {
    enable = lib.mkEnableOption "OBS Studio y plugins";    
  };

  config = lib.mkIf cfg.enable {
    # OBS Studio 
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