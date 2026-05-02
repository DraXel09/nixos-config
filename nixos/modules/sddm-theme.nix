{ pkgs, ... }: {
  services.displayManager.sddm = {
    theme = "pixie";
    # Crucial for Qt6: Use the KDE/Qt6 build of SDDM to fix missing cursors and module errors
    package = pkgs.kdePackages.sddm; 
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 40;
      };
    };
  };

  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "pixie-sddm";
      src = pkgs.fetchFromGitHub {
        owner = "xCaptaiN09";
        repo = "pixie-sddm";
        rev = "main";
        hash = pkgs.lib.fakeHash;
      };
      installPhase = "
        mkdir -p $out/share/sddm/themes/pixie
        cp -r * $out/share/sddm/themes/pixie/
      ";
    })
    # Correct Qt6 dependencies for NixOS
    pkgs.kdePackages.qtdeclarative
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.qt5compat # Included for wider QML component compatibility
    pkgs.bibata-cursors
  ];
}