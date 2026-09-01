{ pkgs, ... }: {
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [ 
    (pkgs.bleachbit.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ 
        pkgs.python3Packages.psutil
      ];
    }))
    waydroid-helper
    gnome-disk-utility
    gamemode
  ];
}
