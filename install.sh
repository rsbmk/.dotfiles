#!/bin/bash

# 🚀 Roberto's Dotfiles - Instalación Automatizada
# Configura un entorno de desarrollo completo desde cero en macOS

set -e  # Salir si algún comando falla

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para imprimir mensajes con colores y emojis
print_status() {
    local status=$1
    local message=$2
    case $status in
        "success") echo -e "${GREEN}✅ $message${NC}" ;;
        "error") echo -e "${RED}❌ $message${NC}" ;;
        "warning") echo -e "${YELLOW}⚠️  $message${NC}" ;;
        "info") echo -e "${BLUE}ℹ️  $message${NC}" ;;
        "step") echo -e "${PURPLE}🔄 $message${NC}" ;;
        "header") echo -e "${CYAN}🚀 $message${NC}" ;;
    esac
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Función para verificar si estamos en macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_status "error" "Este script está diseñado para macOS"
        exit 1
    fi
}

# Función para instalar Homebrew
install_homebrew() {
    print_status "step" "Verificando Homebrew..."
    
    if command_exists brew; then
        print_status "success" "Homebrew ya está instalado"
        # Actualizar Homebrew
        print_status "info" "Actualizando Homebrew..."
        brew update
    else
        print_status "step" "Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Agregar Homebrew al PATH para esta sesión
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f "/usr/local/bin/brew" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        
        print_status "success" "Homebrew instalado correctamente"
    fi
}

# Función para instalar herramientas esenciales
install_essential_tools() {
    print_status "step" "Instalando herramientas esenciales..."
    
    local tools=(
        "git"
        "curl" 
        "wget"
        "fzf"
        "diff-so-fancy"
        "fnm"
        # "exa"
        "bat"
        "ripgrep"
        "git-delta"
        "jq"
        "tree"
    )
    
    for tool in "${tools[@]}"; do
        if command_exists "$tool"; then
            print_status "success" "$tool ya está instalado"
        else
            print_status "info" "Instalando $tool..."
            brew install "$tool"
        fi
    done
    
    # Instalar aplicaciones con cask
    # print_status "step" "Instalando aplicaciones..."
    
    # local cask_apps=(
    #     "visual-studio-code"
    #     "iterm2"
    # )
    
    # for app in "${cask_apps[@]}"; do
    #     if brew list --cask "$app" >/dev/null 2>&1; then
    #         print_status "success" "$app ya está instalado"
    #     else
    #         print_status "info" "Instalando $app..."
    #         brew install --cask "$app" 2>/dev/null || print_status "warning" "No se pudo instalar $app (posiblemente ya existe)"
    #     fi
    # done
}

# Función para instalar Zsh y configurarlo como shell por defecto
setup_zsh() {
    print_status "step" "Configurando Zsh..."
    
    # Zsh ya viene instalado en macOS moderno, pero verificamos
    if ! command_exists zsh; then
        print_status "info" "Instalando Zsh..."
        brew install zsh
    fi
    
    # Cambiar a Zsh como shell por defecto si no lo es ya
    if [[ "$SHELL" != */zsh ]]; then
        print_status "info" "Cambiando shell por defecto a Zsh..."
        chsh -s $(which zsh)
        print_status "success" "Shell cambiado a Zsh (requiere reiniciar terminal)"
    else
        print_status "success" "Zsh ya es el shell por defecto"
    fi
}

# Función para instalar Zim framework
install_zim() {
    print_status "step" "Instalando Zim framework..."
    
    if [[ -d "$HOME/.zim" ]]; then
        print_status "success" "Zim framework ya está instalado"
    else
        print_status "info" "Descargando e instalando Zim..."
        curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
        print_status "success" "Zim framework instalado"
    fi
}

# Función para instalar Spaceship prompt
install_spaceship() {
    print_status "step" "Instalando Spaceship prompt..."
    
    if brew list spaceship >/dev/null 2>&1; then
        print_status "success" "Spaceship prompt ya está instalado"
    else
        print_status "info" "Instalando Spaceship prompt..."
        brew install spaceship
        print_status "success" "Spaceship prompt instalado"
    fi
}

# Función para configurar FZF
setup_fzf() {
    print_status "step" "Configurando FZF..."
    
    # Instalar keybindings y completions
    if [[ -f "$HOME/.fzf.zsh" ]]; then
        print_status "success" "FZF ya está configurado"
    else
        print_status "info" "Configurando keybindings de FZF..."
        $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
        print_status "success" "FZF configurado"
    fi
}

# Función para configurar Git
setup_git() {
    print_status "step" "Configurando Git..."
    
    # Verificar si ya existe configuración
    if git config --global user.name >/dev/null 2>&1; then
        print_status "success" "Git ya tiene configuración de usuario"
    else
        print_status "info" "Git necesitará configuración de usuario después de la instalación"
        print_status "warning" "Ejecuta: git config --global user.name 'Tu Nombre'"
        print_status "warning" "Ejecuta: git config --global user.email 'tu@email.com'"
    fi
}

# Función para configurar Node.js con FNM
setup_nodejs() {
    print_status "step" "Configurando Node.js con FNM..."
    
    # Verificar si fnm está disponible
    if command_exists fnm; then
        # Configurar fnm para esta sesión
        eval "$(fnm env --use-on-cd)"
        
        # Instalar la última versión LTS de Node.js
        print_status "info" "Instalando Node.js LTS..."
        fnm install --lts
        fnm use lts-latest
        fnm default lts-latest
        
        print_status "success" "Node.js $(node --version) instalado y configurado"
    else
        print_status "warning" "FNM no está disponible en esta sesión"
    fi
}

# Función para crear enlaces simbólicos
setup_symlinks() {
    print_status "step" "Configurando enlaces simbólicos..."
    
    # Verificar que estamos en el directorio correcto
    if [[ ! -f "symlinks/links.sh" ]]; then
        print_status "error" "No se encuentra el script de enlaces. ¿Estás en el directorio correcto?"
        return 1
    fi
    
    # Hacer ejecutable el script
    chmod +x symlinks/links.sh
    
    # Ejecutar script de enlaces
    print_status "info" "Creando enlaces simbólicos..."
    ./symlinks/links.sh
    
    print_status "success" "Enlaces simbólicos configurados"
}

# Función para configurar SSH
setup_ssh() {
    print_status "step" "Configurando SSH..."
    
    # Crear directorio SSH si no existe
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    
    print_status "info" "Directorio SSH configurado"
    print_status "warning" "Recuerda generar tus claves SSH:"
    print_status "warning" "ssh-keygen -t ed25519 -C 'tu-email@ejemplo.com' -f ~/.ssh/nombre_clave"
}

# Función para mostrar resumen final
show_summary() {
    print_status "header" "🎉 ¡Instalación Completada!"
    echo
    print_status "success" "Tu entorno de desarrollo está listo"
    echo
    print_status "info" "Próximos pasos:"
    echo "   1. Reinicia tu terminal o ejecuta: source ~/.zshrc"
    echo "   2. Configura Git con tu información:"
    echo "      git config --global user.name 'Tu Nombre'"
    echo "      git config --global user.email 'tu@email.com'"
    echo "   3. Genera tus claves SSH según necesites"
    echo "   4. Instala extensiones de VS Code que uses habitualmente"
    echo
    print_status "info" "Comandos útiles:"
    echo "   • Validar enlaces: ./symlinks/links.sh --validate"
    echo "   • Actualizar Zim: zimfw update && zimfw upgrade"
    echo "   • Ver aliases: alias | grep -E '^(g|d|c)'"
    echo
    print_status "success" "¡Disfruta tu nuevo entorno de desarrollo! 🚀"
}

# Función principal
main() {
    print_status "header" "🚀 Roberto's Dotfiles - Instalación Automatizada"
    echo
    print_status "info" "Este script instalará y configurará todo lo necesario para tu entorno de desarrollo"
    echo
    
    # Verificar macOS
    check_macos
    
    # Verificar que estamos en el directorio correcto
    if [[ ! -f "symlinks/links.sh" ]] || [[ ! -f "terminal/init.sh" ]]; then
        print_status "error" "Debes ejecutar este script desde el directorio .dotfiles"
        print_status "info" "Ejecuta: cd ~/.dotfiles && ./install.sh"
        exit 1
    fi
    
    print_status "info" "Iniciando instalación..."
    echo
    
    # Proceso de instalación
    install_homebrew
    echo
    
    install_essential_tools
    echo
    
    setup_zsh
    echo
    
    install_zim
    echo
    
    install_spaceship
    echo
    
    setup_fzf
    echo
    
    setup_git
    echo
    
    setup_nodejs
    echo
    
    setup_symlinks
    echo
    
    setup_ssh
    echo
    
    show_summary
}

# Función para mostrar ayuda
show_help() {
    echo "🚀 Roberto's Dotfiles - Instalación Automatizada"
    echo
    echo "Uso: ./install.sh [opciones]"
    echo
    echo "Opciones:"
    echo "  -h, --help     Mostrar esta ayuda"
    echo "  -y, --yes      Ejecutar sin confirmaciones interactivas"
    echo
    echo "Este script instalará:"
    echo "  • Homebrew (si no está instalado)"
    echo "  • Herramientas esenciales (git, fzf, diff-so-fancy, etc.)"
    echo "  • Zsh y Zim framework"
    echo "  • Spaceship prompt"
    echo "  • Node.js con FNM"
    echo "  • Configuraciones via enlaces simbólicos"
    echo "  • Y mucho más..."
}

# Procesar argumentos de línea de comandos
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    -y|--yes)
        print_status "info" "Modo automático activado"
        ;;
    "")
        # Sin argumentos, continuar normalmente
        ;;
    *)
        print_status "error" "Argumento desconocido: $1"
        show_help
        exit 1
        ;;
esac

# Ejecutar función principal
main "$@"