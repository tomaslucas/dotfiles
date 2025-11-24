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
- `cldy` - claude --dangerously-skip-permissions

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

### 4. Herramientas opcionales (se configuran automáticamente si están instaladas)

El `.zshrc` detecta y configura automáticamente estas herramientas si las tienes instaladas. **No son obligatorias**, pero si las usas, el .zshrc las configurará por ti:

#### NVM (Node Version Manager)

**Linux y macOS:**
```bash
# Instalación mediante script oficial
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Después de instalar, el .zshrc lo configurará automáticamente
# Uso: nvm install 20, nvm use 20, etc.
```

#### Rust y Cargo

**Linux y macOS:**
```bash
# Instalación mediante rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# El .zshrc cargará automáticamente el entorno de Cargo
```

#### Bun (JavaScript runtime)

**Linux:**
```bash
curl -fsSL https://bun.sh/install | bash
```

**macOS:**
```bash
brew install bun
# O también: curl -fsSL https://bun.sh/install | bash
```

#### Rancher Desktop (alternativa a Docker Desktop)

**Linux:**
```bash
# Descarga desde https://rancherdesktop.io/
# O mediante gestor de paquetes según tu distribución
```

**macOS:**
```bash
brew install --cask rancher
```

### 5. Recargar configuración

```bash
# Recarga la configuración
source ~/.zshrc

# O simplemente abre una nueva terminal
```

## Personalización

### Modificar el prompt

Edita la sección `PROMPT=` en el archivo `.zshrc` (alrededor de la línea 41).

### Añadir más aliases

Añade tus aliases personalizados al final del archivo `.zshrc` en la sección de aliases adicionales.

### Cambiar colores de FZF

Modifica la variable `FZF_DEFAULT_OPTS` (alrededor de la línea 218-226).

## Compatibilidad

Esta configuración detecta automáticamente el sistema operativo y ajusta:
- Rutas de plugins (diferentes en Linux/macOS)
- Comandos específicos del OS (dircolors, notify-send, etc.)
- Keybindings específicos de terminal
- Carga herramientas opcionales solo si están instaladas (NVM, Cargo, Bun, Rancher Desktop, direnv)

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

### Verificar si las herramientas opcionales están configuradas

Para verificar si NVM, Cargo, Bun u otras herramientas opcionales se cargaron correctamente:

```bash
# Verificar NVM
command -v nvm

# Verificar Cargo/Rust
command -v cargo

# Verificar Bun
command -v bun

# Verificar direnv
command -v direnv

# Ver todas las variables de entorno configuradas
env | grep -E "NVM|CARGO|BUN|RANCHER"
```

Si alguna herramienta no se carga, verifica que esté instalada en la ubicación esperada:
- NVM: `~/.nvm/nvm.sh`
- Cargo: `~/.cargo/env`
- Rancher Desktop: `~/.rd/bin` (macOS) o `~/.rd/bin` (Linux)

## Notas

- **Historial**: Se guarda en `~/.zsh_history` (10000 líneas)
- **Autocompletado**: Case-insensitive por defecto
- **Autocorrección**: Activada para comandos y argumentos
- **Detección automática de OS**: El .zshrc detecta si estás en Linux o macOS y ajusta rutas y configuraciones automáticamente
