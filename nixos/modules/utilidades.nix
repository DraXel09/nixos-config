{ lib, config, pkgs, ... }:
{
  # Opción simple para activar/desactivar este conjunto de paquetes
  options.utilidades.enable = lib.mkOption {
    description = "Enable custom package set";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.utilidades.enable {
    # --- Diccionarios ---
    environment.pathsToLink = [ "/share/hunspell" "/share/hyphen" ];
    environment.variables.DICPATH = "${pkgs.hunspell}/share/hunspell";

    # --- Flatpak ---
    services.flatpak.enable = true;

    # --- Soporte binarios externos ---
    programs.nix-ld.enable = true;

    # --- AppImage ---
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # --- Paquetes del Sistema ---
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
      hunspellDicts.es_ES  # Cambiado a español
      hunspellDicts.en_US-large
      hyphen
    ];

    # --- NoiseTorch (Opcional y corregido) ---
    # Habilita el programa, pero NO inicia la UI automáticamente.
    # Tú lanzas 'noisetorch' desde el menú de aplicaciones cuando lo necesites.
    # ograms.noisetorch.enable = true;
  };
}
