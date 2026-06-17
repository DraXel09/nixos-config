{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu_kvm
    virt-manager
  ];
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;  # TPM emulado
    };
  };
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.users.joellyb = {
    isNormalUser = true;
    extraGroups = [ "libvirtd" "wheel" "kvm" "qemu" ];
  };
}