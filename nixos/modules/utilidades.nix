{ lib, config, pkgs, ... }:
{
  # Opción para activar/desactivar este conjunto de paquetes
  options.utilidades.enable = lib.mkOption {
    description = "Enable custom package set";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.utilidades.enable {
    # --- Diccionarios ---
    environment.pathsToLink = [ "/share/hunspell" "/share/hyphen" ];

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
      hunspellDicts.es_ES
      hunspellDicts.en_US-large
      hyphen
    ];

    # --- NoiseTorch ---
    # Habilita el programa, pero NO inicia la UI automáticamente.
    # programs.noisetorch.enable = true;
  };
}
