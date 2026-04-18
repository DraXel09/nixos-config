{ config, pkgs, lib, ... }:
let
  cfg = config.virtualCamera;
in
{
  # --- Declaración de Opciones ---
  options.virtualCamera = {
    enable = lib.mkEnableOption "Virtual Camera support (v4l2loopback) for OBS and other apps";
  };

  config = lib.mkIf cfg.enable {
    # --- Añade el paquete del módulo al kernel actual ---
    boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    
    # --- Fuerza la carga del módulo al inicio ---
    boot.kernelModules = [ "v4l2loopback" ];
    
    # --- Configuración fija y probada (2 dispositivos: video10 y video11) ---
    # exclusive_caps=1 es CRUCIAL para que OBS y Zoom detecten la cámara correctamente
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=2 video_nr=10,11 card_label="OBS Cam","Android Cam" exclusive_caps=1
    '';
  };
}
