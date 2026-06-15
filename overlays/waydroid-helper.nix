{ config, pkgs, ... }: 

{
  nixpkgs.overlays = [
    (final: prev: {
      waydroid-helper = prev.waydroid-helper.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ 
          final.gobject-introspection 
        ];
        propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or []) ++ [ 
          final.vte-gtk4 
          final.vte
        ];
      });
    })
  ];
}