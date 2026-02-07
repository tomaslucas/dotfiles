# Guía de Referencia de tmux

## Conceptos Básicos

### Jerarquía
```
Servidor tmux
├── Sesión 1
│   ├── Ventana 1
│   │   ├── Panel 1
│   │   └── Panel 2
│   └── Ventana 2
└── Sesión 2
```

### Prefix Key
Por defecto: `Ctrl+b` (se muestra como `prefix` en esta guía)

**Opcional**: Puedes cambiar a `Ctrl+a` (más fácil de alcanzar) descomentando en `.tmux.conf`:
```bash
unbind C-b
set -g prefix C-a
bind C-a send-prefix
```

## Gestión de Sesiones

### Crear y Conectar
```bash
tmux                        # Nueva sesión
tmux new -s nombre          # Nueva sesión con nombre
tmux ls                     # Listar sesiones
tmux attach                 # Conectar a última sesión
tmux attach -t nombre       # Conectar a sesión específica
tmux kill-session -t nombre # Eliminar sesión
```

### Dentro de tmux
```
prefix + d                  # Desconectar (detach) de la sesión
prefix + $                  # Renombrar sesión actual
prefix + s                  # Listar y cambiar de sesión
```

## Ventanas (Windows)

### Gestión Básica
```
prefix + c                  # Crear nueva ventana
prefix + ,                  # Renombrar ventana
prefix + w                  # Listar ventanas
prefix + n                  # Siguiente ventana
prefix + p                  # Ventana anterior
prefix + 0-9                # Ir a ventana específica
prefix + &                  # Cerrar ventana (con confirmación)
```

### Atajos Rápidos (SIN PREFIX)
```
Alt+1                       # Ir a ventana 1
Alt+2                       # Ir a ventana 2
Alt+3                       # Ir a ventana 3
...
Alt+9                       # Ir a ventana 9
```

## Paneles (Panes)

### Crear Paneles
```
prefix + |                  # Split vertical (nuevo panel a la derecha)
prefix + -                  # Split horizontal (nuevo panel abajo)
prefix + x                  # Cerrar panel actual
```

### Navegación entre Paneles (estilo Vim)
```
prefix + h                  # Panel izquierda
prefix + j                  # Panel abajo
prefix + k                  # Panel arriba
prefix + l                  # Panel derecha
```

### Redimensionar Paneles (estilo Vim)
```
prefix + H                  # Expandir hacia izquierda
prefix + J                  # Expandir hacia abajo
prefix + K                  # Expandir hacia arriba
prefix + L                  # Expandir hacia derecha
```
*Nota: Puedes mantener presionado para redimensionar continuamente*

### Otras Operaciones
```
prefix + z                  # Zoom (maximizar/restaurar panel)
prefix + !                  # Convertir panel en ventana
prefix + q                  # Mostrar números de paneles
prefix + o                  # Siguiente panel
prefix + {                  # Mover panel hacia arriba
prefix + }                  # Mover panel hacia abajo
prefix + Ctrl+o             # Rotar paneles
prefix + Alt+1-5            # Layouts predefinidos
```

## Modo Copia (Copy Mode)

### Entrar y Salir
```
prefix + [                  # Entrar en modo copia
q                           # Salir de modo copia
```

### Navegación (estilo Vi)
```
h, j, k, l                  # Moverse como en Vim
w, b                        # Palabra siguiente/anterior
0, $                        # Inicio/fin de línea
g, G                        # Inicio/fin del historial
Ctrl+u, Ctrl+d              # Media página arriba/abajo
/                           # Buscar hacia adelante
?                           # Buscar hacia atrás
n, N                        # Siguiente/anterior resultado
```

### Copiar y Pegar
```
v                           # Empezar selección
y                           # Copiar selección (y salir)
Ctrl+v                      # Selección rectangular
prefix + ]                  # Pegar
```

**En macOS**:
- `y` copia al portapapeles del sistema (pbcopy)
- Seleccionar con el mouse también copia automáticamente
- **No requiere** instalar `reattach-to-user-namespace` (tmux 2.6+)

## Configuración Especial

### Características Habilitadas

#### Mouse
```
set -g mouse on
```
- Click para cambiar de panel
- Arrastrar bordes para redimensionar
- Scroll para ver historial
- Doble click para copiar palabras
- Triple click para copiar líneas

#### Numeración desde 1
```
set -g base-index 1
setw -g pane-base-index 1
```
Las ventanas y paneles empiezan en 1 (más fácil en teclado que 0).

#### Re-numeración Automática
```
set -g renumber-windows on
```
Si cierras la ventana 2 de 5, las ventanas 3-5 pasan a ser 2-4.

#### Historial Grande
```
set -g history-limit 10000
```
10,000 líneas de scroll hacia atrás.

#### Escape Rápido
```
set -sg escape-time 10
```
Reduce delay al presionar Escape (importante para Vim dentro de tmux).

#### Nuevas Ventanas/Paneles en Directorio Actual
```
bind c new-window -c "#{pane_current_path}"
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
```

## Barra de Estado

### Información Mostrada

**Izquierda**: `[nombre-sesión]`
**Derecha**: `2025-11-22  14:35:42`

### Formato de Ventanas
```
 1:zsh  2:vim  3:logs*
```
- Número:Nombre
- `*` marca la ventana actual

### Monitoreo de Actividad
```
setw -g monitor-activity on
```
La ventana cambia de color si hay actividad mientras estás en otra.

## Comandos Útiles

### Recargar Configuración
```
prefix + r                  # Recarga ~/.tmux.conf
```
Mensaje: "Config reloaded!" aparecerá.

### Modo Comando
```
prefix + :                  # Entrar en modo comando
```
Aquí puedes ejecutar comandos de tmux directamente, ej:
```
:resize-pane -D 10
:rename-window nuevo-nombre
```

### Información del Sistema
```
prefix + t                  # Mostrar reloj
prefix + i                  # Info del panel actual
```

## Workflows Comunes

### Desarrollo Web Típico
```bash
tmux new -s dev
# Panel 1: Editor (vim)
prefix + -                  # Split horizontal
# Panel 2: Servidor local
prefix + -                  # Split horizontal
# Panel 3: Git/comandos
```

### Multi-proyecto
```bash
tmux new -s proyecto1
prefix + d                  # Detach
tmux new -s proyecto2
prefix + d                  # Detach
tmux ls                     # Ver todas
tmux attach -t proyecto1    # Volver al primero
```

## Combinaciones Poderosas

### Sincronizar Paneles
```
prefix + :setw synchronize-panes on
```
Todos los paneles reciben los mismos comandos (útil para servidores múltiples).

Para desactivar:
```
prefix + :setw synchronize-panes off
```

### Búsqueda en Historial
```
prefix + [                  # Modo copia
/error                      # Buscar "error"
n                           # Siguiente ocurrencia
```

### Cambiar Layout Rápido
```
prefix + Alt+1              # Layout: even-horizontal
prefix + Alt+2              # Layout: even-vertical
prefix + Alt+3              # Layout: main-horizontal
prefix + Alt+4              # Layout: main-vertical
prefix + Alt+5              # Layout: tiled
prefix + Space              # Ciclar entre layouts
```

## Plugins

### TPM (Tmux Plugin Manager)

Los plugins se gestionan con [TPM](https://github.com/tmux-plugins/tpm). Instalación inicial:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Después de instalar TPM, abre tmux y presiona `prefix + I` para instalar los plugins configurados.

**Nota**: Si TPM no está instalado, tmux cargará la configuración normalmente pero mostrará un error en la última línea (`run`). Esto es inofensivo.

#### Gestión de Plugins
```
prefix + I                  # Instalar plugins nuevos
prefix + U                  # Actualizar plugins existentes
prefix + Alt + u            # Desinstalar plugins no listados
```

Los plugins se definen en `.tmux.conf` con `set -g @plugin 'autor/plugin'`.

### tmux-resurrect

Guarda y restaura el estado completo de las sesiones de tmux (sesiones, ventanas, paneles, directorios de trabajo y programas en ejecución).

```
prefix + Ctrl-s             # Guardar sesión
prefix + Ctrl-r             # Restaurar sesión
```

**¿Qué se guarda?**
- Todas las sesiones, ventanas y paneles
- El directorio de trabajo de cada panel
- El layout y tamaño de los paneles
- El contenido visible de los paneles (`@resurrect-capture-pane-contents 'on'`)
- Programas en ejecución (vim, less, man, etc.)

Los datos se almacenan en `~/.tmux/resurrect/`.

### tmux-continuum

Complemento de tmux-resurrect que automatiza el guardado y la restauración:

- **Guardado automático** cada 15 minutos (configurable con `@continuum-save-interval`)
- **Restauración automática** al iniciar el servidor tmux (`@continuum-restore 'on'`)

Esto significa que si reinicias la máquina o matas el servidor tmux, la próxima vez que abras tmux se restaurarán automáticamente tus sesiones.

## Solución de Problemas

### Los colores se ven mal en Vim
Ya está configurado con:
```
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
```

### Quiero el prefix original (Ctrl+b)
Comenta las líneas en `.tmux.conf`:
```bash
# unbind C-b
# set -g prefix C-a
# bind C-a send-prefix
```

### El mouse no funciona
Verifica que esté habilitado:
```
prefix + :set -g mouse on
```

### Las ventanas no se renumeran
```
prefix + :set -g renumber-windows on
```

## Cheat Sheet Rápida

| Acción | Atajo |
|--------|-------|
| **Sesiones** | |
| Nueva sesión | `tmux new -s nombre` |
| Listar | `tmux ls` |
| Conectar | `tmux attach -t nombre` |
| Detach | `prefix + d` |
| **Ventanas** | |
| Nueva | `prefix + c` |
| Siguiente/Anterior | `prefix + n/p` |
| Ir a # | `Alt + #` (sin prefix) |
| Renombrar | `prefix + ,` |
| **Paneles** | |
| Split vertical | `prefix + \|` |
| Split horizontal | `prefix + -` |
| Navegar | `prefix + h/j/k/l` |
| Redimensionar | `prefix + H/J/K/L` |
| Zoom | `prefix + z` |
| **Otros** | |
| Modo copia | `prefix + [` |
| Pegar | `prefix + ]` |
| Recargar config | `prefix + r` |
| Modo comando | `prefix + :` |
| **Plugins** | |
| Guardar sesión | `prefix + Ctrl-s` |
| Restaurar sesión | `prefix + Ctrl-r` |
| Instalar plugins | `prefix + I` |
| Actualizar plugins | `prefix + U` |

## Recursos

- Manual completo: `man tmux`
- Lista de teclas: `prefix + ?`
- GitHub del proyecto: https://github.com/tmux/tmux
- Wiki: https://github.com/tmux/tmux/wiki
- TPM (Plugin Manager): https://github.com/tmux-plugins/tpm
- tmux-resurrect: https://github.com/tmux-plugins/tmux-resurrect
- tmux-continuum: https://github.com/tmux-plugins/tmux-continuum
