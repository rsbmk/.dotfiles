#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directorio base de dotfiles
DOTFILES_DIR="$HOME/.dotfiles"

# Función para imprimir mensajes con colores
print_status() {
    local status=$1
    local message=$2
    case $status in
        "success") echo -e "${GREEN}✓${NC} $message" ;;
        "error") echo -e "${RED}✗${NC} $message" ;;
        "warning") echo -e "${YELLOW}⚠${NC} $message" ;;
        "info") echo -e "${BLUE}ℹ${NC} $message" ;;
    esac
}

# Función para validar si un archivo fuente existe
validate_source() {
    local source_path=$1
    if [[ ! -f "$source_path" ]]; then
        print_status "error" "Archivo fuente no encontrado: $source_path"
        return 1
    fi
    return 0
}

# Función para crear backup de archivos existentes
create_backup() {
    local target_path=$1
    if [[ -f "$target_path" || -L "$target_path" ]]; then
        local backup_path="${target_path}.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$target_path" "$backup_path"
        print_status "warning" "Creado backup: $backup_path"
    fi
}

# Función para crear enlace simbólico con validaciones
create_symlink() {
    local source_path=$1
    local target_path=$2
    local description=$3
    
    print_status "info" "Procesando: $description"
    
    # Validar que el archivo fuente existe
    if ! validate_source "$source_path"; then
        return 1
    fi
    
    # Crear directorio padre si no existe
    local target_dir=$(dirname "$target_path")
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
        print_status "info" "Creado directorio: $target_dir"
    fi
    
    # Crear backup del archivo existente
    create_backup "$target_path"
    
    # Crear enlace simbólico
    if ln -s "$source_path" "$target_path" 2>/dev/null; then
        print_status "success" "Enlace creado: $target_path -> $source_path"
        return 0
    else
        print_status "error" "Error al crear enlace: $target_path"
        return 1
    fi
}

# Función para validar enlaces simbólicos existentes
validate_symlinks() {
    print_status "info" "Validando enlaces simbólicos existentes..."
    
    local links_to_check=(
        "$HOME/.bashrc:$DOTFILES_DIR/terminal/bash/.bashrc"
        "$HOME/.zimrc:$DOTFILES_DIR/terminal/zsh/.zimrc"
        "$HOME/.zshrc:$DOTFILES_DIR/terminal/zsh/.zshrc"
        "$HOME/.gitconfig:$DOTFILES_DIR/git/.gitconfig"
        "$HOME/.gitignore_global:$DOTFILES_DIR/git/.gitignore_global"
        "$HOME/.gitattributes:$DOTFILES_DIR/git/.gitattributes"
        "$HOME/.ssh/config:$DOTFILES_DIR/terminal/config"
    )
    
    for link_info in "${links_to_check[@]}"; do
        local target_path="${link_info%:*}"
        local expected_source="${link_info#*:}"
        
        if [[ -L "$target_path" ]]; then
            local actual_source=$(readlink "$target_path")
            if [[ "$actual_source" == "$expected_source" ]]; then
                print_status "success" "Enlace válido: $target_path"
            else
                print_status "warning" "Enlace incorrecto: $target_path -> $actual_source (esperado: $expected_source)"
            fi
        elif [[ -f "$target_path" ]]; then
            print_status "warning" "Archivo regular encontrado: $target_path (debería ser enlace simbólico)"
        else
            print_status "error" "Enlace no encontrado: $target_path"
        fi
    done
}

# Función principal
main() {
    print_status "info" "Iniciando configuración de enlaces simbólicos..."
    
    # Validar que el directorio de dotfiles existe
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        print_status "error" "Directorio de dotfiles no encontrado: $DOTFILES_DIR"
        exit 1
    fi
    
    # Opción para solo validar enlaces existentes
    if [[ "$1" == "--validate" || "$1" == "-v" ]]; then
        validate_symlinks
        exit 0
    fi
    
    print_status "info" "Creando enlaces simbólicos..."
    
    # Array de enlaces a crear (source:target:description)
    local symlinks=(
        "$DOTFILES_DIR/terminal/bash/.bashrc:$HOME/.bashrc:Bash configuration"
        "$DOTFILES_DIR/terminal/zsh/.zimrc:$HOME/.zimrc:Zim configuration"
        "$DOTFILES_DIR/terminal/zsh/.zshrc:$HOME/.zshrc:Zsh configuration"
        "$DOTFILES_DIR/git/.gitconfig:$HOME/.gitconfig:Git configuration"
        "$DOTFILES_DIR/git/.gitignore_global:$HOME/.gitignore_global:Git global ignore"
        "$DOTFILES_DIR/git/.gitattributes:$HOME/.gitattributes:Git attributes"
        "$DOTFILES_DIR/terminal/config:$HOME/.ssh/config:SSH configuration"
    )
    
    local success_count=0
    local total_count=${#symlinks[@]}
    
    # Crear cada enlace simbólico
    for symlink_info in "${symlinks[@]}"; do
        IFS=':' read -r source_path target_path description <<< "$symlink_info"
        if create_symlink "$source_path" "$target_path" "$description"; then
            ((success_count++))
        fi
    done
    
    # Resumen final
    print_status "info" "Proceso completado: $success_count/$total_count enlaces creados exitosamente"
    
    if [[ $success_count -eq $total_count ]]; then
        print_status "success" "Todos los enlaces simbólicos fueron creados correctamente"
        print_status "info" "Ejecuta '$0 --validate' para verificar los enlaces"
    else
        print_status "warning" "Algunos enlaces no pudieron ser creados. Revisa los errores anteriores."
        exit 1
    fi
}

# Ejecutar función principal con todos los argumentos
main "$@"
