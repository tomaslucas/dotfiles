# VSCode Configuration

Sistema de configuración portable para VSCode sincronizado via Git.

## Filosofía

- **Portable**: Funciona en macOS y Linux sin modificaciones
- **Versionado**: Todo en Git para tracking de cambios
- **Minimalista**: Solo configuraciones que aumentan productividad
- **Documentado**: Cada setting tiene su justificación

## Estructura

```
~/dotfiles/vscode/
├── settings.json              # Configuración portable (en git)
├── keybindings.json           # Keybindings personalizados (en git)
├── snippets/                  # Snippets por lenguaje (en git)
│   ├── python.json
│   └── markdown.json
├── extensions-core.txt        # Extensiones para todas las máquinas
├── extensions-remote.txt      # Extensiones solo para macOS (Remote SSH)
├── extensions-optional.txt    # Extensiones opcionales
├── install.sh                 # Script de instalación automático
└── README.md                  # Este archivo
```

## Instalación

### Primera vez

```bash
# 1. Clonar dotfiles (si no lo tienes ya)
cd ~
git clone <tu-repo-dotfiles> dotfiles

# 2. Ejecutar instalación de VSCode
cd ~/dotfiles/vscode
chmod +x install.sh
./install.sh
```

### Máquina nueva

```bash
# En la nueva máquina
cd ~/dotfiles
git pull
cd vscode
./install.sh
```

## Qué hace install.sh

1. **Backup**: Guarda tu configuración actual en `~/.vscode-backup-YYYYMMDD/`
2. **Symlinks**: Crea enlaces simbólicos de settings, keybindings y snippets
3. **Extensiones**: Instala extensiones desde `extensions-core.txt`
4. **Verificación**: Confirma que todo está correctamente enlazado

## Settings específicos de máquina

Algunos settings NO deben sincronizarse (ej: rutas de Python).

### Opción 1: Comentarios en settings.json (RECOMENDADO)

Al final de `settings.json` hay ejemplos comentados. Descoméntalos y modifica según tu máquina:

```json
// Linux:
"python.defaultInterpreterPath": "/bin/python3",

// macOS (Homebrew):
"python.defaultInterpreterPath": "/opt/homebrew/bin/python3",
```

Estos cambios locales **NO los commitees** - déjalos como modificaciones locales en la máquina.

### Opción 2: Por proyecto (MEJOR)

En lugar de user settings, configura Python interpreter por proyecto:

```bash
cd mi-proyecto
mkdir -p .vscode
cat > .vscode/settings.json << EOF
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python"
}
EOF
```

Esto se commitea con el proyecto y funciona en cualquier máquina.

## Extensiones

### Core (todas las máquinas)

```bash
# Instalar manualmente
cat extensions-core.txt | xargs -L 1 code --install-extension

# O usa install.sh que lo hace automáticamente
```

### Remote SSH (solo macOS)

```bash
cat extensions-remote.txt | xargs -L 1 code --install-extension
```

### Opcionales (según necesidad)

Ver `extensions-optional.txt` e instalar manualmente las que necesites.

## Snippets

### Python

- `s3client` - Boto3 S3 client
- `pdparquet` - Pandas read parquet
- `gluecontext` - AWS Glue context
- `main` - if __name__ == '__main__'
- `dataclass` - Python dataclass
- `logger` - Logging setup
- Y más...

### Markdown

- `kbheader` - Knowledge Base header
- `investigation` - Investigation template
- `mermaid` - Mermaid diagram
- `flowchart` - Flowchart específico
- `adr` - Architecture Decision Record
- Y más...

**Uso**: Escribe el prefix (ej: `s3client`) y presiona `Tab`.

## Actualizar configuración

### Desde cualquier máquina

```bash
cd ~/dotfiles/vscode

# Editar settings
vim settings.json  # o code settings.json

# Commitear y push
git add .
git commit -m "Update: <descripción del cambio>"
git push

# En otras máquinas
git pull
# Los symlinks ya están, cambios se reflejan automáticamente
```

## Verificar instalación

```bash
# Ver que los symlinks están correctos
ls -la ~/.config/Code/User/settings.json        # Linux
ls -la ~/Library/Application\ Support/Code/User/settings.json  # macOS

# Debe mostrar -> apuntando a ~/dotfiles/vscode/settings.json

# Ver extensiones instaladas
code --list-extensions
```

## Troubleshooting

### Los cambios no se reflejan

```bash
# Verificar symlinks
ls -la ~/.config/Code/User/  # Linux
ls -la ~/Library/Application\ Support/Code/User/  # macOS

# Re-ejecutar install.sh
cd ~/dotfiles/vscode
./install.sh
```

### Conflicto en settings.json

Si Git muestra conflicto:

```bash
# Ver diferencias
git diff settings.json

# Resolver manualmente
code settings.json

# O aceptar versión del repo
git checkout -- settings.json
```

### Extensión no se instala

```bash
# Verificar nombre exacto
code --list-extensions | grep <nombre>

# Buscar en marketplace
# https://marketplace.visualstudio.com/vscode

# Instalar manualmente desde UI
# Cmd+Shift+X -> buscar -> Install
```

## Decisiones de diseño

### ¿Por qué no VSCode Settings Sync?

Settings Sync (built-in) sincroniza TODO automáticamente, pero:
- No tienes control sobre qué se sincroniza
- No puedes versionar con git
- Dificulta debug de problemas
- No permite comments en JSON
- No separa portable vs específico de máquina

### ¿Por qué symlinks y no copiar archivos?

- **Un source of truth**: Editas en un solo lugar
- **Sin duplicación**: No hay que copiar manualmente
- **Git tracking**: Todos los cambios versionados
- **Instantáneo**: Cambios se reflejan en todas las ventanas de VSCode

### ¿Por qué comentarios en JSON en vez de merge de archivos?

- **Simplicidad**: No requiere scripts complejos
- **Transparencia**: Ves exactamente qué está activo
- **Compatible**: VSCode soporta JSON con comments (JSON5)
- **Debuggeable**: No hay transformaciones ocultas

## Próximos pasos

Ver cada Fase del aprendizaje:

- **Fase 1**: ✅ Arquitectura y modelo mental
- **Fase 2**: ✅ Sistema de configuración portable (aquí estamos)
- **Fase 3**: Optimización para casos de uso (Python, Jupyter, Markdown)
- **Fase 4**: Workflows avanzados (Tasks, Keybindings, Multi-root)
- **Fase 5**: Mantenimiento y evolución

## Referencias

- [VSCode Settings Sync](https://code.visualstudio.com/docs/editor/settings-sync)
- [VSCode User Guide](https://code.visualstudio.com/docs/editor/codebasics)
- [Dotfiles Best Practices](https://dotfiles.github.io/)
