‎# fonts.nix
‎{ pkgs, ... }:

{‎
‎  fonts = {
‎    # Habilita el directorio X11 si usas apps antiguas o WINE
‎    fontDir.enable = true;
‎
‎    # Todas tus fuentes deben centralizarse aquí
‎    packages = with pkgs; [
‎      corefonts                 # Fuentes clásicas de Microsoft
‎      vista-fonts               # Fuentes modernas de Microsoft
‎      noto-fonts                # Soporte global de idiomas de Google
‎      noto-fonts-cjk-sans       # Caracteres asiáticos
‎      noto-fonts-emoji          # Emojis del sistema
‎      nerd-fonts.jetbrains-mono # Tu fuente para la terminal
‎    ];
‎
‎    # Opcional: Define tus fuentes por defecto para el sistema
‎    fontconfig.defaultFonts = {
‎      serif = [ "Times New Roman" "Noto Serif" ];
‎      sansSerif = [ "Arial" "Noto Sans" ];
‎      monospace = [ "JetBrainsMono Nerd Font" ];
‎      emoji = [ "Noto Color Emoji" ];
‎    };
‎  };
‎}
‎
‎fonts.packages = with pkgs; [
‎  noto-fonts
‎  noto-fonts-cjk-sans
‎  noto-fonts-emoji
‎  liberation_ttf
‎  fira-code
‎  fira-code-symbols
‎  mplus-outline-fonts.githubTypewriter
‎  dina-font
‎  proggyfonts
‎];
