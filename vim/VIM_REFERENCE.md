# Guía de Referencia de Vim

## Configuración General

### Interfaz
- **Números de línea híbridos**: Muestra números absolutos y relativos
- **Resaltado de línea actual**: Visual feedback de dónde estás
- **Soporte de mouse**: Puedes hacer clic y seleccionar
- **Wildmenu**: Autocompletado mejorado de comandos (`:` + Tab)

### Indentación
- **4 espacios por tabulación**: Configuración estándar
- **Tabs → Espacios**: Convierte automáticamente
- **Indentación inteligente**: Detecta contexto automáticamente

### Búsqueda
- **Búsqueda incremental**: Muestra resultados mientras escribes
- **Resaltado de resultados**: Todos los matches se resaltan
- **Case-smart**: `/foo` encuentra "foo", "Foo", "FOO"; `/Foo` solo encuentra "Foo"

### Archivos
- **Sin archivos swap**: No más `.swp` molestos
- **Undo persistente**: Puedes deshacer incluso después de cerrar el archivo
  - Historial guardado en: `~/.vim/undodir`
- **Auto-recarga**: Si el archivo cambia externamente, se recarga automáticamente

## Atajos de Teclado

### Navegación Básica
```
h, j, k, l          - Izquierda, abajo, arriba, derecha
w, b                - Siguiente/anterior palabra
0, $                - Inicio/fin de línea
gg, G               - Inicio/fin de archivo
{número}G           - Ir a línea específica (ej: 42G)
Ctrl+u, Ctrl+d      - Medio página arriba/abajo
```

### Con Números Relativos
```
5j                  - Bajar 5 líneas
10k                 - Subir 10 líneas
3w                  - Avanzar 3 palabras
```

### Edición
```
i, a                - Insert antes/después del cursor
I, A                - Insert inicio/fin de línea
o, O                - Nueva línea abajo/arriba
dd                  - Borrar línea
yy                  - Copiar línea
p, P                - Pegar después/antes
u                   - Deshacer
Ctrl+r              - Rehacer
.                   - Repetir último comando
```

### Búsqueda
```
/texto              - Buscar hacia adelante
?texto              - Buscar hacia atrás
n, N                - Siguiente/anterior resultado
*                   - Buscar palabra bajo el cursor
Space               - LIMPIA RESALTADO (custom)
```

### Navegación entre Ventanas (Splits)
```
Ctrl+h              - Ventana izquierda
Ctrl+j              - Ventana abajo
Ctrl+k              - Ventana arriba
Ctrl+l              - Ventana derecha
```

### Comandos de Splits
```
:split              - Split horizontal
:vsplit             - Split vertical
:close              - Cerrar ventana actual
Ctrl+w =            - Igualar tamaño de ventanas
```

### Visual Mode
```
v                   - Visual mode (selección)
V                   - Visual line (líneas completas)
Ctrl+v              - Visual block (columnas)
```

### Clipboard del Sistema
```
"+y                 - Copiar a clipboard del sistema
"+p                 - Pegar desde clipboard del sistema
```
Con `set clipboard=unnamed` configurado, `y` y `p` ya usan el clipboard del sistema.

### Comandos Útiles
```
:w                  - Guardar
:q                  - Salir
:wq o :x            - Guardar y salir
:q!                 - Salir sin guardar
:e archivo          - Abrir archivo
:%s/old/new/g       - Reemplazar en todo el archivo
:noh                - Limpiar resaltado (también Space)
```

## Configuraciones Destacadas

### Scrolloff
```
set scrolloff=8
```
Mantiene siempre 8 líneas visibles arriba y abajo del cursor. El cursor nunca está en el borde de la pantalla.

### Wildmode
```
set wildmenu
set wildmode=longest:full,full
```
Cuando presionas Tab en el modo comando (`:`), muestra sugerencias inteligentes.

### Updatetime
```
set updatetime=300
```
Mejora la velocidad de respuesta (importante para plugins en el futuro).

## Python
```
let python_highlight_all = 1
```
Resaltado de sintaxis mejorado para Python (strings, números, funciones built-in, etc.).

## Tips Rápidos

### Movimientos Eficientes
- Usa números con comandos: `d3w` borra 3 palabras
- Usa `.` para repetir: `dd` luego `.` borra líneas rápidamente
- Combina operators: `ci"` = cambiar texto dentro de comillas

### Búsqueda y Reemplazo
```
:%s/foo/bar/g       - Reemplazar todo
:%s/foo/bar/gc      - Reemplazar con confirmación
:s/foo/bar/g        - Reemplazar solo en línea actual
```

### Macros (Avanzado)
```
qa                  - Empezar a grabar macro en registro 'a'
q                   - Terminar grabación
@a                  - Ejecutar macro 'a'
@@                  - Repetir última macro
```

## Solución de Problemas

### Los números relativos me confunden
Edita `~/.vimrc` y comenta la línea:
```vim
" set relativenumber
```

### Quiero que se ajusten las líneas largas
Edita `~/.vimrc` y cambia:
```vim
set wrap
```

### Prefiero tabs en lugar de espacios
Edita `~/.vimrc` y comenta:
```vim
" set expandtab
```

## Recursos
- Tutorial interactivo: Ejecuta `vimtutor` en la terminal
- Ayuda interna: `:help` + tema (ej: `:help navigation`)
- Cheat sheet: https://vim.rtorr.com/
