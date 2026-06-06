{ config, pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  imports = [
    ./home-packages.nix
    ./modules/bundle-home.nix
  ];

  # Shell
  programs.bash.enable = true;
}
