{ config, pkgs, ... }:

let
  temaXenlismNixOS = pkgs.stdenv.mkDerivation {
    pname = "xenlism-grub-nixos-1080p";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "xenlism";
      repo = "Grub-themes";
      rev = "40ac048df9aacfc053c515b97fcd24af1a06762f";
      sha256 = "sha256-ProTKsFocIxWAFbYgQ46A+GVZ7mUHXxZrvdiPJqZJ6I";
    };

    installPhase = ''
      mkdir -p $out
      cp -r xenlism-grub-1080p-nixos/Xenlism-Nixos/* $out/
    '';
  };
in
{
  boot.loader.grub = {
    theme = temaXenlismNixOS;
  };
}