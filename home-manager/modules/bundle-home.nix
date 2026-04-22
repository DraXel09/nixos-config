{
  imports = [
    ./gaming-home.nix
    ./obs.nix
  ];

  # Activación de Modulos
  streaming.enable = true;     # OBS
  gamingHome.enable = true;    # Gaming
}
