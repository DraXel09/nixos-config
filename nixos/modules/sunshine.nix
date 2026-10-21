{ config, lib, ... }:
let
  cfg = config.sunshine;
in
{
  options.sunshine.enable = lib.mkEnableOption "configuración de Sunshine";
  
  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        max_bitrate = 0;  # Forzar un techo de bitrate 30000 (30 Mbps) o 0 para no limitarlo.
        encoder = "vaapi";
        width  = 1920;
        height = 1080;
        fps    = 60;
        vaapi_rc = "vbr";
        vaapi_quality = "balanced";
        vaapi_strict_rc_buffer = "enabled"; 
        enable_input = true;
        key_repeat_delay = 500;
        key_repeat_frequency = 24.9;
        mouse_smoothness = 1;
      };
    };
    # Permite que la sesión remota acceda a mandos conectados
    services.udev.extraRules = ''
      KERNEL=="event[0-9]*", SUBSYSTEM=="input", TAG+="uaccess"
    '';
  };
}