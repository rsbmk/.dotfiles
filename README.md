# 🚀 Roberto's Dotfiles

Una configuración completa y personalizada para el entorno de desarrollo en macOS, que incluye configuraciones optimizadas para terminal, Git, SSH y herramientas de desarrollo.

## 📋 Tabla de Contenidos

- [✨ Características](#-características)
- [📁 Estructura del Proyecto](#-estructura-del-proyecto)
- [🛠️ Instalación](#️-instalación)
- [🔧 Uso del Script de Enlaces](#-uso-del-script-de-enlaces)
- [⚙️ Configuraciones Incluidas](#️-configuraciones-incluidas)
- [🎯 Aliases y Funciones](#-aliases-y-funciones)
- [🔄 Actualización y Mantenimiento](#-actualización-y-mantenimiento)
- [🤝 Contribuir](#-contribuir)

## ✨ Características

- **🔗 Enlaces Simbólicos Inteligentes**: Script automatizado para crear y validar enlaces simbólicos
- **🐚 Configuración Multi-Shell**: Soporte completo para Bash y Zsh
- **🎨 Prompt Personalizado**: Usando Zim framework con tema Asciiship
- **⚡ Aliases Optimizados**: Más de 60 aliases para Git, Docker y desarrollo
- **🔧 Funciones Avanzadas**: Integración con FZF para navegación interactiva
- **📡 Configuración SSH**: Setup completo para múltiples cuentas y servicios
- **🗂️ Git Configurado**: Settings optimizados con diff-so-fancy y reglas globales

## 📁 Estructura del Proyecto

```
.dotfiles/
├── git/                    # Configuraciones de Git
│   ├── .gitconfig         # Configuración principal de Git
│   ├── .gitignore_global  # Reglas globales de ignore
│   └── .gitattributes     # Atributos de archivos
├── terminal/              # Configuraciones de terminal
│   ├── _aliases/          # Aliases personalizados
│   │   └── aliases        # 60+ aliases para Git, Docker, etc.
│   ├── _exports/          # Variables de entorno
│   │   └── exports.sh     # PATH y configuraciones FZF
│   ├── _functions/        # Funciones bash/zsh
│   │   └── functions      # Funciones interactivas con FZF
│   ├── bash/             # Configuraciones de Bash
│   │   └── .bashrc       # Configuración principal de Bash
│   ├── zsh/              # Configuraciones de Zsh
│   │   ├── .zshrc        # Configuración principal de Zsh
│   │   └── .zimrc        # Configuración del framework Zim
│   ├── config            # Configuración SSH
│   └── init.sh           # Script de inicialización
└── symlinks/             # Sistema de enlaces simbólicos
    └── links.sh          # Script automatizado de enlaces
```

## 🛠️ Instalación

### Prerequisitos

Antes de instalar, asegúrate de tener instalado:

```bash
# Instalar Homebrew (si no lo tienes)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar herramientas esenciales
brew install git curl wget
brew install fzf diff-so-fancy
brew install fnm  # Node Version Manager (opcional)
```

### Paso a Paso

1. **Clonar el repositorio en tu directorio home:**
   ```bash
   cd ~
   git clone https://github.com/robertobocio/dotfiles.git .dotfiles
   cd .dotfiles
   ```

2. **Hacer el script ejecutable:**
   ```bash
   chmod +x symlinks/links.sh
   ```

3. **Validar archivos antes de la instalación (opcional):**
   ```bash
   ./symlinks/links.sh --validate
   ```

4. **Crear enlaces simbólicos:**
   ```bash
   ./symlinks/links.sh
   ```

5. **Instalar Zim framework (para Zsh):**
   ```bash
   # Si usas Zsh, instalar Zim
   curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
   ```

6. **Reiniciar tu terminal o recargar configuración:**
   ```bash
   # Para Zsh
   source ~/.zshrc
   
   # Para Bash
   source ~/.bashrc
   ```

7. **Configurar FZF (opcional pero recomendado):**
   ```bash
   # Instalar FZF keybindings
   $(brew --prefix)/opt/fzf/install
   ```

## 🔧 Uso del Script de Enlaces

El script `symlinks/links.sh` es la herramienta principal para gestionar los enlaces simbólicos:

### Comandos Disponibles

```bash
# Crear todos los enlaces simbólicos
./symlinks/links.sh

# Validar enlaces existentes (sin modificar)
./symlinks/links.sh --validate
./symlinks/links.sh -v

# Ver ayuda
./symlinks/links.sh --help
```

### Características del Script

- ✅ **Validación automática**: Verifica que los archivos fuente existen
- 🔄 **Backups seguros**: Crea respaldos automáticos con timestamp
- 🎨 **Output colorizado**: Mensajes claros con códigos de color
- 📊 **Reportes detallados**: Información completa del proceso
- 🛡️ **Manejo de errores**: Gestión robusta de situaciones inesperadas

### Enlaces Creados

El script crea los siguientes enlaces simbólicos:

| Destino | Origen | Descripción |
|---------|--------|-------------|
| `~/.bashrc` | `terminal/bash/.bashrc` | Configuración de Bash |
| `~/.zshrc` | `terminal/zsh/.zshrc` | Configuración de Zsh |
| `~/.zimrc` | `terminal/zsh/.zimrc` | Configuración de Zim |
| `~/.gitconfig` | `git/.gitconfig` | Configuración de Git |
| `~/.gitignore_global` | `git/.gitignore_global` | Ignores globales |
| `~/.gitattributes` | `git/.gitattributes` | Atributos de Git |
| `~/.ssh/config` | `terminal/config` | Configuración SSH |

## ⚙️ Configuraciones Incluidas

### 🐚 Terminal (Bash/Zsh)

- **Framework Zim** con plugins optimizados
- **Prompt Asciiship** con información de Git
- **Syntax highlighting** y autosuggestions
- **History search** mejorado
- **FZF integration** para navegación interactiva

### 🔧 Git

- **Diff-so-fancy** para diffs mejorados
- **Delta** para visualización avanzada
- **Editor VS Code** por defecto
- **Autocorrección** activada
- **Aliases** integrados con el framework Zim

### 🔑 SSH

- **Múltiples identidades** (trabajo, personal, servicios)
- **Configuración para GitHub** y GitLab
- **Servidores remotos** preconfigurados
- **Include de OrbStack** para desarrollo local

## 🎯 Aliases y Funciones

### Git Aliases Principales

```bash
# Básicos
gs          # git status
gaa         # git add -A
gc "msg"    # git commit -m "msg"
gl          # git log --graph --abbrev-commit

# Branches y navegación (con FZF)
gsw         # git switch (interactivo)
gswr        # git switch remote branch
gbd         # git branch delete (múltiple)

# Stash
gsts        # git stash save
gsta        # git stash apply
gstc        # git stash clear
```

### Funciones Interactivas

```bash
# Navegación de código
jl          # Cambiar a proyecto Jelou
mc          # Cambiar a proyecto MC
dev         # Cambiar a proyecto Dev
cdd         # Cambiar directorio (interactivo)

# Docker
dexec       # Ejecutar en container (interactivo)
drun        # Iniciar container (interactivo)
dstop       # Parar container (interactivo)
dcu         # Docker compose up (interactivo)

# Git avanzado
gda         # Git add (interactivo con preview)
gp          # Git pull (con selección de branch)
gpsh        # Git push (con selección de branch)
```

### Aliases de Utilidad

```bash
# Sistema
c           # clear
la          # ls -a
dotfiles    # cd ~/.dotfiles
symlinks    # ejecutar script de enlaces

# Desarrollo
installsub  # npm install en subdirectorios
uninstallsub # limpiar node_modules
uninstalldep # limpiar dependencias completas

# Updates
zimup       # actualizar Zim framework
up          # actualizar sistema (apt)
```

## 🔄 Actualización y Mantenimiento

### Actualizar Dotfiles

```bash
# Ir al directorio de dotfiles
dotfiles

# Actualizar desde el repositorio
git pull origin main

# Re-ejecutar enlaces si hay cambios
./symlinks/links.sh
```

### Actualizar Herramientas

```bash
# Actualizar Zim framework
zimup

# Actualizar Homebrew y paquetes
brew update && brew upgrade

# Actualizar FZF
brew upgrade fzf
```

### Backup y Restauración

Los archivos originales se respaldan automáticamente cuando ejecutas el script:

```bash
# Los backups se crean con formato:
~/.bashrc.backup.20240130_143021
~/.zshrc.backup.20240130_143021
# etc.

# Para restaurar un backup:
mv ~/.bashrc.backup.20240130_143021 ~/.bashrc
```

## 🔍 Solución de Problemas

### Script de Enlaces Falla

```bash
# Verificar permisos
chmod +x symlinks/links.sh

# Validar archivos fuente
./symlinks/links.sh --validate

# Verificar que estás en el directorio correcto
pwd  # Debería ser ~/.dotfiles
```

### Zsh No Carga Configuración

```bash
# Verificar que Zim está instalado
ls ~/.zim

# Reinstalar Zim si es necesario
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# Recargar configuración
source ~/.zshrc
```

### FZF No Funciona

```bash
# Verificar instalación
which fzf

# Reinstalar keybindings
$(brew --prefix)/opt/fzf/install

# Verificar en .zshrc
grep -n "fzf" ~/.zshrc
```

## 🤝 Contribuir

1. **Fork** el repositorio
2. **Crea** una branch para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. **Commit** tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. **Push** a la branch (`git push origin feature/nueva-funcionalidad`)
5. **Crea** un Pull Request

### Estructura para Nuevas Configuraciones

```bash
# Para agregar una nueva herramienta:
1. Crear archivo de configuración en la carpeta apropiada
2. Agregar enlace simbólico en symlinks/links.sh
3. Documentar en README.md
4. Probar con ./symlinks/links.sh --validate
```

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

---

**⭐ Si estos dotfiles te son útiles, no olvides darle una estrella al repositorio!**

## 🙏 Agradecimientos

- [Zim Framework](https://zimfw.sh/) - Framework de Zsh
- [FZF](https://github.com/junegunn/fzf) - Command-line fuzzy finder
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) - Diffs mejorados
- [Asciiship](https://github.com/zimfw/asciiship) - Prompt theme
- [Spaceship Prompt](https://spaceship-prompt.sh/) - Prompt theme
- [Starship](https://starship.rs/) - Prompt theme

## 💻 Configuración Específica para macOS

### Herramientas Recomendadas Adicionales

```bash
# Terminal mejorado
brew install --cask iterm2

# Herramientas de desarrollo
brew install git-delta
brew install exa  # Reemplazo moderno de ls
brew install bat  # Reemplazo mejorado de cat
brew install ripgrep  # Búsqueda rápida en archivos

# Opcional: Gestores de Node.js
brew install fnm  # Fast Node Manager (ya incluido en exports)
```

### Configuración de VS Code

Para que el comando `code` funcione desde terminal:

1. Abrir VS Code
2. Cmd+Shift+P → "Shell Command: Install 'code' command in PATH"
3. Reiniciar terminal

### Configuración SSH

Después de la instalación, configurar tus claves SSH:

```bash
# Generar clave SSH para GitHub (trabajo)
ssh-keygen -t ed25519 -C "tu-email@trabajo.com" -f ~/.ssh/work

# Generar clave SSH para desarrollo personal
ssh-keygen -t ed25519 -C "tu-email@personal.com" -f ~/.ssh/dev

# Agregar claves al ssh-agent
ssh-add ~/.ssh/work
ssh-add ~/.ssh/dev
```

Luego editar `~/.ssh/config` (que es un enlace a `terminal/config`) para ajustar tus configuraciones específicas.

---

*README generado automáticamente para el proyecto dotfiles de Roberto Bocio*