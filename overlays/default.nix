{ config, pkgs, ... }:

{
  nixpkgs.overlays = [ 
    (import ./waydroid-helper.nix)
    (import ./goverlay-bgmod-fix.nix)
  ];
}
