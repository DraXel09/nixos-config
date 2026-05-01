{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Desarrollo
    vscode-fhs
    nixd
    nixfmt

    # Utilidades personales
    vlc
    scrcpy
    gearlever
    libreoffice-qt-fresh

    # Temas y personalización
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
  ];
}
