{ pkgs, ... }:
{
  fonts = { 
    fontDir.enable = true;
    packages = with pkgs; [
      corefonts
      vista-fonts
      fire-code
      fire-code-symbols
      
    ];
  }
}