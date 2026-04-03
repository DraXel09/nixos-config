{ config, pkgs, lib, ... }:
{
  # === Declaración de la opción ===
  options.plasma.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable KDE Plasma desktop environment customizations";
  };

  # === Configuración condicional ===
  config = lib.mkIf config.plasma.enable { 

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Portales XDG (esencial para sandboxing)
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
      xdgOpenUsePortal = true;
    };

    # Paquetes específicos
    environment.plasma6.excludePackages = [ 
        pkgs.kdePackages.discover 
    ];
    environment.systemPackages = with pkgs; [
      kdePackages.kpmcore
      kdePackages.kcalc
      kdePackages.qtwebengine
      kdePackages.filelight
      kdePackages.kate
    ];

    # Integración móvil
    programs.kdeconnect.enable = true;

    # (Opcional) Evitar TTY1 compitiendo con SDDM
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false; 

    # Local 
    i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_EC.UTF-8";
    LC_IDENTIFICATION = "es_EC.UTF-8";
    LC_MEASUREMENT = "es_EC.UTF-8";
    LC_MONETARY = "es_EC.UTF-8";
    LC_NAME = "es_EC.UTF-8";
    LC_NUMERIC = "es_EC.UTF-8";
    LC_PAPER = "es_EC.UTF-8";
    LC_TELEPHONE = "es_EC.UTF-8";
    LC_TIME = "es_EC.UTF-8";
    };

    # Ahorrar espacio
    documentation.nixos.enable = false;
  };
}
