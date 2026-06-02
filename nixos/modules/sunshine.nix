{ config, lib, ... }:

let 
  cfg = config.sunshine;
in 
{
  options.sunshine.enable = lib.mkEnableOption "configuración de Sunshine";

  config = lib.mkIf cfg.enable {
    # Servicio principal
    services.sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;         # Abre automáticamente los puertos necesarios

      settings = {
        port             = 47990;    # Puerto de escucha
        encoder          = "vaapi";
        width            = 1920;
        height           = 1080;
        fps              = 60;
        bitrate          = 30000;    
        key_repeat_delay = 500;      
        key_repeat_rate  = 30;
        mouse_smoothness = 1;        # Minimiza input lag
        enable_input     = true;
      };
    };

    # Permite que la sesión remota acceda a mandos conectados
    services.udev.extraRules = ''
      KERNEL=="event[0-9]*", SUBSYSTEM=="input", TAG+="uaccess"
    '';

    # Notas de mantenimiento:
    # - Si necesitas preconfigurar aplicaciones, usa `services.sunshine.applications`.
  };
}
