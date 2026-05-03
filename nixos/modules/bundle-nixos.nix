{
  imports = [
    ./plasma.nix
    ./tweaks.nix
    ./boot.nix
    ./virtual-camera.nix
    ./utilidades.nix
    ./gaming-system.nix
    ./sunshine.nix
    ./grub-theme.nix
    ./sddm-theme.nix
    ./plymouth-theme.nix
  ];

  # === Activación de Modulos ===
  # Gaming
  programs.gaming = {
    enable = true;
    enableProtonGE = true;
    enableInputRemapper = false;
  };
  virtualCamera.enable = false; # Virtal Camera (SCRCPY)
  plasma.enable = true;         # plasma.nix
  utilidades.enable = true;     # utilidades.nix
  tweaks.enable = true;         # tweaks.nix
  myBoot.enable = true;         # Activar boot.nix
  sunshine.enable = true;       # Activar sunshine.nix
}
