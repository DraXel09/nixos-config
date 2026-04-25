{ config, pkgs, ... }: {
  programs.eden.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [ 
    bleachbit
    gparted
  ];
}
