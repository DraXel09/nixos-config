{ config, pkgs, username, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # Módulos personales
    ./modules/bundle-nixos.nix
    ./local-packages.nix
  ];

  # === Kernel ===
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # === Identidad ===
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # === Boot ===
  boot.loader = { 
    grub.enable = true;
    grub.device = "nodev";
    grub.efiSupport = true; 
    grub.useOSProber = false;
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
  };

  # === Plymouth: mínimo necesario ===
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  # === Locale & Time ===
  time.timeZone = "America/Guayaquil";
  i18n.defaultLocale = "es_MX.UTF-8";
 
  # === KDE Plasma 6 ===
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb.layout = "latam";
  services.libinput.enable = true;
  console.keyMap = "la-latin1";

  # === Audio ===
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
   # jack.enable = true;
  };

  # === Usuario ===
  users.users.${username} = {
    isNormalUser = true;
    description = "Joelly Bedoya";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # === Sistema Base ===
  services.printing.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = false;
  services.tuned.enable = true;
  services.tuned.ppdSupport = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}

