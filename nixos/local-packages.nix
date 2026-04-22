{ config, pkgs, ... }: {
  programs.eden.enable = true;
  environment.systemPackages = with pkgs; [
     gparted
  ];
}
