{ pkgs, inputs, ... }: {
  services.displayManager.sddm = {
    theme = "pixie";
    extraPackages = [
      pkgs.kdePackages.qtdeclarative
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qt5compat
    ];
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 40;
      };
    };
  };

  environment.systemPackages = [
    (inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
      background = "../assets/sddm/background.png";
      avatar = "../assets/sddm/avatar.png";
      autocolor = true;
      fontFamily = "JetBrains Mono";
      fontSize = 12;
    })
    pkgs.bibata-cursors
  ];
}