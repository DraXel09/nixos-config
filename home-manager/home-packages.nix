{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Desarrollo
    vscode-fhs

    # Utilidades personales
    #telegram-desktop
    obs-studio
    vlc
    scrcpy
    gearlever
  ];
}
