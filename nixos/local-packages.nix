{ pkgs, ... }: {
  programs.eden.enable = true;
  programs.firefox.enable = true;
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
  environment.systemPackages = with pkgs; [ 
    bleachbit
    gparted
    waydroid-helper
  ];
}
