# NixOS Config

Configuración declarativa de mi NixOS con flakes.

## 🚀 Uso

```bash
# Clonar y aplicar
git clone https://github.com/DraXel09/nixos-config.git /etc/nixos
cd /etc/nixos
sudo nixos-rebuild switch --flake .#nixos
```

## 📂 Estructura
```
/etc/nixos/
├── flake.nix                 # Entry point
├── nixos/                    # Configuración del sistema
│   ├── configuration.nix
│   └── modules/
└── home-manager/             # Configuración de usuario
    ├── home.nix
    └── modules/
```

## 🔧 Comandos útiles
```bash
# Reconstruir sistema
sudo nixos-rebuild switch --flake .#nixos

# Actualizar flakes
nix flake update

# Ver generaciones
nixos-rebuild list-generations

# Limpiar store
sudo nix-collect-garbage -d
```

---

*Config generado con ❤️ y NixOS*
```
