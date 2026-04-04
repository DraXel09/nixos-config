{ config, pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  imports = [
    ./home-packages.nix
    ./modules/bundle-home.nix
  ];

  # === Shell ===
  programs.bash.enable = true;

  # === Git Config (Solo usuario) ===

  # === Archivos de configuración (Dotfiles) ===
  # Ejemplo: Enlazar configuraciones específicas de usuario
  # home.file.".config/mi-app".source = ./config/mi-app;
}
