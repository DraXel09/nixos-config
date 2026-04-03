```markdown
# Mi Configuración de NixOS

> Configuración declarativa de NixOS con flakes

## 📋 Información del Sistema

- **Hostname:** nixos
- **Usuario:** joellyb
- **Desktop Environment:** KDE Plasma 6
- **Window Manager:** SDDM
- **File System:** Btrfs

## 🚀 Características

- ✅ Flake-based configuration
- ✅ Home Manager integration
- ✅ KDE Plasma 6
- ✅ PipeWire audio
- ✅ NetworkManager
- ✅ SSH configurado
- ✅ Tuned para optimización

## 📂 Estructura

```
/etc/nixos/
├── flake.nix                 # Flake principal
├── flake.lock                # Lock file para reproducibilidad
├── nixos/
│   ├── configuration.nix     # Configuración principal del sistema
│   ├── hardware-configuration.nix
│   ├── local-packages.nix
│   └── modules/
│       └── bundle-nixos.nix
└── home-manager/
    ├── home.nix              # Configuración de Home Manager
    ├── home-packages.nix
    └── modules/
        ├── bundle-home.nix
        ├── gaming-home.nix
        └── obs.nix
```

## 🔧 Instalación

```bash
# Clonar el repositorio
git clone https://github.com/DraXel09/nixos-config.git /etc/nixos
cd /etc/nixos

# Reconstruir el sistema
sudo nixos-rebuild switch --flake .#nixos

# Actualizar Home Manager
home-manager switch --flake .#joellyb@nixos
```

## 🎯 Comandos Útiles

```bash
# Reconstruir sistema
sudo nixos-rebuild switch --flake .#nixos

# Reconstruir y hacer boot
sudo nixos-rebuild boot --flake .#nixos

# Actualizar flakes
nix flake update

# Ver generaciones
nixos-rebuild list-generations

# Garbage collection
sudo nix-collect-garbage -d
```

## 🛠️ Mantenimiento

- **Actualizaciones:** `nix flake update && sudo nixos-rebuild switch`
- **Limpiar store:** `sudo nix-collect-garbage -d`
- **Optimizar:** `sudo nix-store --optimize`

## 📌 Notas

- Sistema configurado para Lenovo IdeaPad
- Kernel: Linux latest
- Locale: es_MX.UTF-8
- Timezone: America/Guayaquil

## 🔐 Seguridad

- SSH con autenticación por clave
- Firewall habilitado
- Root login deshabilitado (solo con clave)

---

**State Version:** 25.11  
**Última actualización:** $(date +%Y-%m-%d)
```
