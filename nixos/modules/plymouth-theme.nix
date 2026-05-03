{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.adi1090x-plymouth-themes.override {
      selected_themes = [ "loader_2" ];
    })
  ];

  boot.plymouth = {
    theme = "loader_2";
    themePackages = [
      (pkgs.adi1090x-plymouth-themes.override {
        selected_themes = [ "loader_2" ];
      })
    ];
  };
}