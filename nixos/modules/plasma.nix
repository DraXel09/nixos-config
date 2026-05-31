{ config, pkgs, lib, ... }:

let
  cfg = config.plasma;
in 
{
  # --- Declaración de la opción ---
  options.plasma = {
    enable = lib.mkEnableOption "Habilitar configuraciones extras de KDE";
  };

  config = lib.mkIf cfg.enable { 

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Portales XDG
    xdg.portal = {
      enable = true;
      extraPortals = [ 
        pkgs.kdePackages.xdg-desktop-portal-kde 
      ];
      xdgOpenUsePortal = true;
    };

    # Paquetes específicos
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        discover
    ];
    environment.systemPackages = with pkgs; [
      kdePackages.kcalc
      kdePackages.kate
      kdePackages.filelight
      kdePackages.qtwebengine
      kdePackages.kpmcore
    ];

    # Integración móvil
    programs.kdeconnect.enable = true;

    # Fix en aplicaciones GTK
    environment.variables = {
    GTK_MODULES = ""; 
    };

    # SDDM
    services.displayManager.sddm = {
      wayland.enable = true;
      autoNumlock = true;
    };

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
