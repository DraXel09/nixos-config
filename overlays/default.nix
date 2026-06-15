{ config, pkgs, ... }:

{
  nixpkgs.overlays = [ 
    (import ./waydroid-helper.nix)
  ];
}