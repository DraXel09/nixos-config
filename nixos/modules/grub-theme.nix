{ config, pkgs, ... }:{
  boot.loader.grub = { 
    darkmatter-theme = {
    enable = true;
    style = "nixos";      
    icon = "color"; 
  };
 };
}
