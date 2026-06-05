{ pkgs, ... }:
{
  fonts = { 
    fontDir.enable = true;
    packages = with pkgs; [
      corefonts
      vista-fonts
      fira-code
      fira-code-symbols
    ];
  };
}