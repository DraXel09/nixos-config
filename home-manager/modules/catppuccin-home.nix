{ config, pkgs, ... }: { 
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = "kvantum";
  };
  
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "blue";
    kvantum.enable = true;
    gtk.enable = true;
    konsole.enable = true;
  };

  home.packages = with pkgs; [
    kdePackages.qtstyleplugins-kvantum
    kdePackages.qt6ct
  ];
}