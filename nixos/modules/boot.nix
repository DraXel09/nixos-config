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
    boot.kernelParams = [ 
      "quiet" 
      "splash"
      "loglevel=3"
      "vt.global_cursor_default=0"
      "udev.log_priority=3"
      "rd.udev.log_level=3"
      "systemd.show_status=false"
    ];
    boot.loader.timeout = 3;
    boot.loader.grub.configurationLimit = 5;
    boot.initrd.systemd.enable = true;
  };
}
