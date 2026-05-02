{ config, pkgs, ... }:

let
  temaXenlismNixOS = pkgs.stdenv.mkDerivation {
    pname = "xenlism-grub-nixos-1080p";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "xenlism";
      repo = "Grub-themes";
      rev = "5e75f9b3ea9061dca6c53d34e166e08bf9ebc7c7";  # Commit fijo
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # Hash SRI
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