{
  imports = [
    ./plasma.nix
    ./tweaks.nix
    ./boot.nix
    #./virtual-camera.nix
    ./utilidades.nix
    ./gaming-system.nix
    ./sunshine.nix
    ./grub-theme.nix
    ./sddm-theme.nix
    ./plymouth-theme.nix
    ./fonts.nix
    ./virtual-hub.nix
  ];

  programs.gaming.enable = true;# Gaming support system-wide
  plasma.enable = true;         # plasma.nix
  utilidades.enable = true;     # utilidades.nix
  tweaks.enable = true;         # tweaks.nix
  sunshine.enable = true;       # Activar sunshine.nix
}
