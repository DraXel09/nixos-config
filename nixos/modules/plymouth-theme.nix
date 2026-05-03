{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (plymouth-themes.override {
      selected_themes = [ "loader_2" ];
    })
  ];

  # Configuración activa de Plymouth
  boot.plymouth = {
    theme = "loader_2";
  };
}