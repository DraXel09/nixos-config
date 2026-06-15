{ config, pkgs, ... }:

{ 
  virtualisation = {
    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
      swtpm.enable = true;
    };
    libvirt.enable = true;
  };
  programs.virt-manager.enable = true;
  users.users.joellyb = {
    isNormalUser = true;
    extraGroups = [ "libvirt" "wheel" "kvm" ];
  };
}