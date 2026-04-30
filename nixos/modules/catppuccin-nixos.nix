{ config, pkgs, ... }: {
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "blue";
  };

  # Grub con tema de Catppuccin

  # SDDM con tema de Catppuccin
  services.displayManager.sddm = {
    theme = "catppuccin-frappe";
    package = pkgs.kdePackages.sddm;
  };
}