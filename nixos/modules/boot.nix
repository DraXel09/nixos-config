{ config, lib, pkgs, ... }:
let cfg = config.myBoot; in
{
  options.myBoot.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable my boot tweaks";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = lib.mkDefault [ "quiet" "splash" ];
    boot.loader.timeout = lib.mkDefault 3;
    boot.loader.grub.configurationLimit = lib.mkDefault 5;
  };
}
