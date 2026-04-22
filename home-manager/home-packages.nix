{ config, pkgs, ... }: {
  programs.firefox.enable = true;
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
  ];
}
