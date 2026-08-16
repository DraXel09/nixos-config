{ config, pkgs, ... }:

{
  # Waydroid
   virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  # Containers
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  home.packages = with pkgs; [
    distrobox
  ];

  # VM
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.users.joellyb.extraGroups = [ "libvirtd" ];
}