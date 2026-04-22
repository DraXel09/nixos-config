{ config, lib, pkgs, ... }:

let 
  cfg = config.myBoot; 
in
{
  options.myBoot = {
    enable = lib.mkEnableOption "Habilitar configs de arranque";
  };

  config = lib.mkIf cfg.enable {

    # --- Boot Tweaks ---
    boot.kernelParams = [ "quiet" "splash" ];
    boot.loader.timeout = 3;
    boot.loader.grub.configurationLimit = 5;
  };
}
