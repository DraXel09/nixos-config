{ config, lib, pkgs, ... }:

let 
  cfg = config.utilidades;
in 
{
  options.utilidades = {
    enable = lib.mkEnableOption "Utilidades adicionales para el sistema";
  };

  config = lib.mkIf cfg.enable {

    # Hardware gráfico y multimedia
    hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;
      graphics.extraPackages = with pkgs; [ 
        # rocmPackages.clr.icd  # Para Davinci Resolve
      ];
      # opentabletdriver.enable = true; # Soporte para tabletas gráficas
    };
   
    # Soporte para Flatpak, AppImage y Nix-ld
    services.flatpak.enable = true;
    programs.nix-ld.enable = true;
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # Diccionarios
    environment.pathsToLink = [ "/share/hunspell" "/share/hyphen" ];

    # Paquetes del Sistema
    environment.systemPackages = with pkgs; [
      # Multimedia
      ffmpeg
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-libav

      # Utilidades
      git
      wget
      fastfetch 
      btop
      pciutils
      libva-utils
      usbutils
      ntfs3g
      exfat
      android-tools
      adbfs-rootless

      # Compresión
      zip
      unzip
      p7zip
      xz
      gzip
      zstd
      unrar

      # Idioma
      hunspell
      hunspellDicts.es_ES
      hunspellDicts.en_US-large
      hyphen
    ];
  };
}
