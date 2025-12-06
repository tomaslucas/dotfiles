#!/usr/bin/env bash

# ============================================================================
# VSCode Configuration Installer
# ============================================================================
# Este script:
# 1. Detecta el sistema operativo (macOS/Linux)
# 2. Hace backup de configuración existente
# 3. Crea symlinks de settings, keybindings y snippets
# 4. Instala extensiones core
# 5. Verifica instalación
#
# Uso: ./install.sh

set -euo pipefail

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Funciones auxiliares
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Detectar sistema operativo
detect_os() {
    case "$(uname -s)" in
        Darwin*)    echo "macos" ;;
        Linux*)     echo "linux" ;;
        *)          error "Sistema operativo no soportado: $(uname -s)" ;;
    esac
}

# Obtener directorio de configuración de VSCode según OS
get_vscode_dir() {
    local os=$1
    if [[ "$os" == "macos" ]]; then
        echo "$HOME/Library/Application Support/Code/User"
    elif [[ "$os" == "linux" ]]; then
        echo "$HOME/.config/Code/User"
    fi
}

# Crear backup de configuración existente
backup_config() {
    local vscode_dir=$1
    local backup_dir="$HOME/.vscode-backup-$(date +%Y%m%d-%H%M%S)"
    
    if [[ -d "$vscode_dir" ]]; then
        info "Creando backup en: $backup_dir"
        mkdir -p "$backup_dir"
        
        # Backup de archivos importantes
        for file in settings.json keybindings.json; do
            if [[ -f "$vscode_dir/$file" ]] && [[ ! -L "$vscode_dir/$file" ]]; then
                cp "$vscode_dir/$file" "$backup_dir/"
                info "  ✓ Backup de $file"
            fi
        done
        
        # Backup de snippets
        if [[ -d "$vscode_dir/snippets" ]] && [[ ! -L "$vscode_dir/snippets" ]]; then
            cp -r "$vscode_dir/snippets" "$backup_dir/"
            info "  ✓ Backup de snippets/"
        fi
        
        echo "$backup_dir"
    else
        warn "No existe configuración previa en $vscode_dir"
        echo ""
    fi
}

# Crear symlink con verificación (sin borrar datos)
create_symlink() {
    local source=$1
    local target=$2
    local name=$3
    local backup_suffix=".backup-$(date +%Y%m%d-%H%M%S)"

    # Crear directorio padre si no existe
    mkdir -p "$(dirname "$target")"

    # Si existe y no es symlink, moverlo a backup (más seguro que rm)
    if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
        info "  Moviendo $name existente a backup: ${name}${backup_suffix}"
        mv "$target" "${target}${backup_suffix}"
    elif [[ -L "$target" ]]; then
        # Si ya es symlink, solo eliminarlo (es seguro)
        rm -f "$target"
    fi

    # Crear symlink
    ln -sn "$source" "$target"

    # Verificar
    if [[ -L "$target" ]] && [[ -e "$target" ]]; then
        info "  ✓ Symlink creado: $name"
        return 0
    else
        error "  ✗ Falló creación de symlink: $name"
        return 1
    fi
}

# Instalar extensiones
install_extensions() {
    local extensions_file=$1
    
    if [[ ! -f "$extensions_file" ]]; then
        warn "No se encontró $extensions_file"
        return
    fi
    
    info "Instalando extensiones desde $extensions_file..."
    
    while IFS= read -r extension; do
        # Ignorar líneas vacías y comentarios
        [[ -z "$extension" ]] && continue
        [[ "$extension" =~ ^# ]] && continue
        
        # Verificar si ya está instalada
        if code --list-extensions | grep -qi "^${extension}$"; then
            info "  ✓ Ya instalada: $extension"
        else
            info "  → Instalando: $extension"
            if code --install-extension "$extension" --force > /dev/null 2>&1; then
                info "    ✓ Instalada"
            else
                warn "    ✗ Error al instalar $extension"
            fi
        fi
    done < "$extensions_file"
}

# Verificar instalación
verify_installation() {
    local vscode_dir=$1
    local dotfiles_dir=$2
    local all_ok=true
    
    info "Verificando instalación..."
    
    # Verificar settings.json
    if [[ -L "$vscode_dir/settings.json" ]] && 
       [[ "$(readlink "$vscode_dir/settings.json")" == "$dotfiles_dir/settings.json" ]]; then
        info "  ✓ settings.json → correcto"
    else
        warn "  ✗ settings.json → incorrecto"
        all_ok=false
    fi
    
    # Verificar keybindings.json
    if [[ -L "$vscode_dir/keybindings.json" ]] && 
       [[ "$(readlink "$vscode_dir/keybindings.json")" == "$dotfiles_dir/keybindings.json" ]]; then
        info "  ✓ keybindings.json → correcto"
    else
        warn "  ✗ keybindings.json → incorrecto"
        all_ok=false
    fi
    
    # Verificar snippets
    if [[ -L "$vscode_dir/snippets" ]] && 
       [[ "$(readlink "$vscode_dir/snippets")" == "$dotfiles_dir/snippets" ]]; then
        info "  ✓ snippets/ → correcto"
    else
        warn "  ✗ snippets/ → incorrecto"
        all_ok=false
    fi
    
    if $all_ok; then
        info "¡Instalación completada con éxito!"
    else
        warn "Algunos symlinks no están correctos. Revisa los mensajes arriba."
    fi
}

# Main
main() {
    echo "============================================================================"
    echo "VSCode Configuration Installer"
    echo "============================================================================"
    echo
    
    # Detectar OS
    local os
    os=$(detect_os)
    info "Sistema operativo: $os"
    
    # Obtener directorios
    local vscode_dir
    vscode_dir=$(get_vscode_dir "$os")
    info "Directorio VSCode: $vscode_dir"
    
    local dotfiles_dir
    dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    info "Directorio dotfiles: $dotfiles_dir"
    echo
    
    # Verificar que code está instalado
    if ! command -v code &> /dev/null; then
        error "VSCode 'code' command no encontrado. Instala VSCode primero."
    fi
    
    # Backup
    local backup_dir
    backup_dir=$(backup_config "$vscode_dir")
    if [[ -n "$backup_dir" ]]; then
        info "Backup completado: $backup_dir"
    fi
    echo
    
    # Crear symlinks
    info "Creando symlinks..."
    create_symlink "$dotfiles_dir/settings.json" "$vscode_dir/settings.json" "settings.json"
    create_symlink "$dotfiles_dir/keybindings.json" "$vscode_dir/keybindings.json" "keybindings.json"
    create_symlink "$dotfiles_dir/snippets" "$vscode_dir/snippets" "snippets/"
    echo
    
    # Instalar extensiones core
    install_extensions "$dotfiles_dir/extensions-core.txt"
    echo
    
    # Si es macOS, instalar extensiones remote
    if [[ "$os" == "macos" ]] && [[ -f "$dotfiles_dir/extensions-remote.txt" ]]; then
        install_extensions "$dotfiles_dir/extensions-remote.txt"
        echo
    fi
    
    # Verificar
    verify_installation "$vscode_dir" "$dotfiles_dir"
    echo
    
    # Instrucciones finales
    info "Próximos pasos:"
    echo "  1. Abre VSCode y verifica que la configuración se aplicó"
    echo "  2. Si necesitas settings específicos de máquina, edita:"
    echo "     $dotfiles_dir/settings.json"
    echo "     (hay ejemplos comentados al final del archivo)"
    echo "  3. Instala extensiones opcionales si las necesitas:"
    echo "     cat $dotfiles_dir/extensions-optional.txt"
    echo

    # Informar sobre backups locales si existen
    if ls "$vscode_dir"/*.backup-* &> /dev/null; then
        info "Nota: Se crearon backups locales en:"
        echo "  $vscode_dir/*.backup-*"
        echo "  Puedes eliminarlos manualmente si todo funciona correctamente"
        echo
    fi

    info "¡Listo! 🎉"
}

main "$@"
