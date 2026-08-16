{ pkgs, ... }: {
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [ 
    bleachbit
    waydroid-helper
    gnome-disk-utility
    gamemode
  ];
}
