{ config, lib, ... }:

{
  options.sunshine.enable = lib.mkEnableOption "configuración de Sunshine";

  config = lib.mkIf config.sunshine.enable {
    # Servicio principal
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;          # Necesario para acceso a GPU y dispositivos de entrada
      openFirewall = true;         # Abre automáticamente los puertos necesarios

      settings = {
        port             = 47990;    # Puerto de escucha
        encoder          = "vaapi";  # Optimizado para AMD Vega iGPU
        width            = 1920;
        height           = 1080;
        fps              = 60;
        bitrate          = 60000;    # Recomendado para LAN estable
        key_repeat_delay = 500;
        key_repeat_rate  = 30;
        mouse_smoothness = 1;        # Minimiza input lag
        enable_input     = true;     # Permite control remoto de ratón/teclado/mando
      };
    };

    # Permite que la sesión remota acceda a mandos conectados
    services.udev.extraRules = ''
      KERNEL=="event[0-9]*", SUBSYSTEM=="input", TAG+="uaccess"
    '';

    # Notas de mantenimiento:
    # - Si necesitas preconfigurar aplicaciones, usa `services.sunshine.applications`.
    # - Para captura de audio con PipeWire, descomenta y ajusta `services.pipewire.wireplumber.extraConfig`.
  };
}
