# Instalación Rápida - VSCode Configuration

## Archivos creados

✅ **10 archivos** en total:
- `settings.json` - Configuración portable (127 líneas, altamente comentada)
- `keybindings.json` - Placeholder para Fase 4
- `snippets/python.json` - 13 snippets útiles para data engineering
- `snippets/markdown.json` - 12 snippets para Knowledge Base
- `extensions-core.txt` - 18 extensiones esenciales
- `extensions-remote.txt` - 3 extensiones para Remote SSH (solo macOS)
- `extensions-optional.txt` - 5 extensiones opcionales
- `install.sh` - Script de instalación automático (300+ líneas)
- `.gitignore` - Protección contra commits accidentales
- `README.md` - Documentación completa

## Instalación en tus máquinas

### Paso 1: Descargar archivos

Descarga la carpeta `vscode-config` de los outputs de esta conversación.

### Paso 2: Mover a dotfiles

```bash
# En Linux
cd ~
mv ~/Downloads/vscode-config ~/dotfiles/vscode

# Verificar
ls -la ~/dotfiles/vscode/
```

### Paso 3: Ejecutar instalación

```bash
cd ~/dotfiles/vscode
chmod +x install.sh
./install.sh
```

El script:
1. ✅ Detecta tu OS (macOS/Linux)
2. ✅ Hace backup de tu config actual
3. ✅ Crea symlinks de settings/keybindings/snippets
4. ✅ Instala extensiones core
5. ✅ Verifica que todo funciona

### Paso 4: Repetir en macOS

```bash
# En macOS (mismo proceso)
cd ~/dotfiles/vscode
./install.sh
```

### Paso 5: Commitear a Git

```bash
cd ~/dotfiles
git add vscode/
git commit -m "Add: VSCode portable configuration system"
git push
```

## Primer uso

1. **Abre VSCode** → Verás la configuración aplicada
2. **Prueba snippets**:
   - En archivo `.py` escribe `s3client` + Tab
   - En archivo `.md` escribe `kbheader` + Tab
3. **Revisa extensiones**: `Cmd+Shift+X`
4. **Settings específicos** (si necesitas):
   - Abre `~/dotfiles/vscode/settings.json`
   - Descomenta ejemplos al final del archivo
   - Modifica según tu máquina

## Próximos pasos educativos

Continuaremos con:
- **Fase 3**: Optimizar para tus workflows (Python, Jupyter, Markdown)
- **Fase 4**: Keybindings y Tasks avanzados
- **Fase 5**: Mantenimiento

## Ayuda

Si algo falla:
1. Lee el output del `install.sh` - indica errores claramente
2. Verifica symlinks: `ls -la ~/.config/Code/User/` (Linux)
3. Re-ejecuta: `./install.sh` (es idempotente)

¿Listo para instalar? 🚀
