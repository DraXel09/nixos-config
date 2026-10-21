{ config, ... }:

{    
  # Añade el paquete del módulo al kernel actual
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback.out
  ]; 
  # Fuerza la carga del módulo al inicio
  boot.kernelModules = [ "v4l2loopback" ];
    
  # Configuración fija y probada (2 dispositivos: video10 y video11)
  boot.extraModprobeConfig = ''
   options v4l2loopback devices=2 video_nr=10,11 card_label="OBS Cam","Android Cam" exclusive_caps=1
  '';
}
