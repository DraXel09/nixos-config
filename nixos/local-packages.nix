{ pkgs, eden, ... }: {
  nixpkgs.overlays = [ eden.overlays.default ];
  programs.eden.enable = true;
  programs.firefox.enable = true;
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  environment.systemPackages = with pkgs; [ 
    bleachbit
    waydroid-helper
    gnome-disk-utility
    gamemode
  ];
}
