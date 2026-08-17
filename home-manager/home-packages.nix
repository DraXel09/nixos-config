{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Desarrollo
    vscode-fhs
    nixd
    nixfmt

    # Utilidades personales
    vlc
    scrcpy
    libreoffice-qt-fresh
    distrobox
  ];
}
