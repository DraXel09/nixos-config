{ pkgs, inputs, ... }: {
  programs.firefox.enable = true;
  nixpkgs.overlays = [ inputs.lsfg-vk.overlays.default ];
  environment.systemPackages = with pkgs; [ 
    (bleachbit.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ 
        pkgs.python3Packages.psutil
      ];
    }))
    waydroid-helper
    gnome-disk-utility
    gamemode
    lsfg-vk
  ];
}
