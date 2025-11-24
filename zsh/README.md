# ZSH Configuration

Configuración personalizada de ZSH con soporte multiplataforma (Linux y macOS).

## Características

### Prompt Personalizado
- Muestra el directorio actual en amarillo
- Información de Git (rama actual, archivos staged/unstaged)
- Indicador de entorno virtual de Python activo
- Prompt minimalista con símbolo ❯

### Plugins
- **zsh-autosuggestions**: Sugiere comandos basándose en tu historial (Ctrl+Space para aceptar)
- **zsh-syntax-highlighting**: Colorea la sintaxis de los comandos mientras escribes
- **FZF**: Búsqueda fuzzy para archivos (Ctrl+T), directorios (Alt+C), e historial (Ctrl+R)

### Aliases Útiles

#### Navegación
- `..`, `...`, `....` - Subir 1, 2, 3 directorios
- Navegación automática sin `cd` (solo escribe el directorio)

#### Eza (sustituto moderno de ls)
- `ls` - Lista con iconos
- `ll` - Lista detallada
- `la` - Muestra archivos ocultos
- `lt` - Vista de árbol
- `lsg` - Lista con estado de Git

#### Git
- `gs` - git status
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gl` - git log con gráfico
- `gd` - git diff
- `gco` - git checkout

#### Python
- `vnv` - Activa entorno virtual `.venv`
- `addpyignore` - Descarga .gitignore para Python

#### Claude
- `cld` - claude
- `cldp` - claude -p
- `cldy` - claude

### Keybindings
- **Ctrl+Left/Right**: Moverse por palabras
- **Ctrl+Backspace**: Borrar palabra anterior
- **Ctrl+Space**: Aceptar sugerencia de autocompletado
- **Ctrl+R**: Búsqueda fuzzy en historial (FZF)
- **Ctrl+T**: Búsqueda fuzzy de archivos (FZF)
- **Alt+C**: Búsqueda fuzzy de directorios (FZF)

## Instalación

### 1. Backup de tu configuración actual

```bash
# Guarda tu .zshrc actual por si acaso
cp ~/.zshrc ~/.zshrc.backup
```

### 2. Crear symlink

```bash
# Elimina el .zshrc actual
rm ~/.zshrc

# Crea un symlink al .zshrc del repositorio
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```

### 3. Instalar dependencias

#### Linux (Debian/Ubuntu)

```bash
# Plugins ZSH
sudo apt install zsh-autosuggestions zsh-syntax-highlighting

# FZF (fuzzy finder)
sudo apt install fzf

# Eza (sustituto moderno de ls)
sudo apt install eza

# fd (sustituto moderno de find, opcional pero recomendado)
sudo apt install fd-find

# direnv (gestión de variables de entorno por directorio)
sudo apt install direnv
```

#### macOS

```bash
# Instalar Homebrew si no lo tienes
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Plugins ZSH
brew install zsh-autosuggestions zsh-syntax-highlighting

# FZF (fuzzy finder)
brew install fzf
# Instalar keybindings (opcional, el .zshrc ya los carga)
$(brew --prefix)/opt/fzf/install

# Eza (sustituto moderno de ls)
brew install eza

# fd (sustituto moderno de find, opcional pero recomendado)
brew install fd

# direnv (gestión de variables de entorno por directorio)
brew install direnv
```

### 4. Recargar configuración

```bash
# Recarga la configuración
source ~/.zshrc

# O simplemente abre una nueva terminal
```

## Personalización

### Modificar el prompt

Edita la sección `PROMPT=` en el archivo `.zshrc` (línea 40-42).

### Añadir más aliases

Añade tus aliases personalizados al final del archivo `.zshrc`.

### Cambiar colores de FZF

Modifica la variable `FZF_DEFAULT_OPTS` (línea 228-236).

## Compatibilidad

Esta configuración detecta automáticamente el sistema operativo y ajusta:
- Rutas de plugins (diferentes en Linux/macOS)
- Comandos específicos del OS (dircolors, notify-send, etc.)
- Keybindings específicos de terminal

## Troubleshooting

### Los plugins no se cargan

Verifica que los plugins estén instalados:

```bash
# Linux
ls /usr/share/zsh-autosuggestions/
ls /usr/share/zsh-syntax-highlighting/

# macOS
ls /opt/homebrew/share/zsh-autosuggestions/
ls /opt/homebrew/share/zsh-syntax-highlighting/
```

### FZF no funciona

Verifica que FZF esté instalado:

```bash
fzf --version
```

Si está instalado pero no funciona, intenta:

```bash
# Linux
ls /usr/share/doc/fzf/examples/

# macOS
ls /opt/homebrew/opt/fzf/shell/
```

### Eza no está disponible

Si `eza` no está instalado, el `.zshrc` automáticamente usará `ls` estándar con colores.

Para instalar eza:
- Linux: `sudo apt install eza`
- macOS: `brew install eza`

## Notas

- **Historial**: Se guarda en `~/.zsh_history` (1000 líneas)
- **Undo persistente**: Vim guarda historial de deshacer en `~/.vim/undodir`
- **Autocompletado**: Case-insensitive por defecto
- **Autocorrección**: Activada para comandos y argumentos
