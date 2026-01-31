# ============================================================================
# OS Detection
# ============================================================================

# Detect operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    export IS_MAC=true
    export IS_LINUX=false
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export IS_MAC=false
    export IS_LINUX=true
else
    export IS_MAC=false
    export IS_LINUX=false
fi

# ===== GIT LANGUAGE CONFIGURATION =====
# Use English for Git messages (consistent across all systems)
export LC_MESSAGES=en_US.UTF-8

# ===== PROMPT CONFIGURATION =====

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' %F{blue}[%b%f%F{red}%u%c%F{blue}]%f'
zstyle ':vcs_info:git:*' actionformats ' %F{blue}[%b|%a%f%F{red}%u%c%F{blue}]%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'

# Enable parameter expansion, command substitution, and arithmetic in prompts
setopt PROMPT_SUBST

# Function to display Python virtual environment
function virtualenv_info {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo " %F{green}($(basename $VIRTUAL_ENV))%f"
    fi
}

# Build the prompt - muestra usuario y hostname si es remoto
if [[ -n "$SSH_CONNECTION" ]]; then
    PROMPT='%F{green}%n%f@%F{cyan}%m%f %F{yellow}%~%f${vcs_info_msg_0_}$(virtualenv_info)
%F{green}❯%f '
else
    PROMPT='%F{green}%n%f %F{yellow}%~%f${vcs_info_msg_0_}$(virtualenv_info)
%F{green}❯%f '
fi

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2

# OS-specific dircolors configuration
if [[ "$IS_LINUX" == true ]]; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
elif [[ "$IS_MAC" == true ]]; then
    # macOS uses LSCOLORS instead of LS_COLORS
    export CLICOLOR=1
    export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
fi

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ===== PATH Configuration =====
export PATH="$HOME/.local/bin:$PATH"

# ===== Bun Configuration =====
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ===== Direnv Hook =====
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# ===== Cargo/Rust Configuration =====
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# ===== NVM Configuration =====
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# ===== Rancher Desktop Configuration =====
if [[ "$IS_MAC" == true ]] && [ -d "$HOME/.rd/bin" ]; then
    export PATH="$HOME/.rd/bin:$PATH"
elif [[ "$IS_LINUX" == true ]] && [ -d "$HOME/.rd/bin" ]; then
    export PATH="$HOME/.rd/bin:$PATH"
fi

# ===== Color Support for ls and grep =====
if [[ "$IS_LINUX" == true ]]; then
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
elif [[ "$IS_MAC" == true ]]; then
    # macOS grep color support
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ===== Eza Aliases (replacement for ls) =====
# Only set if eza is installed
if command -v eza &> /dev/null; then
    alias ls="eza --icons"               # Muestra archivos con iconos
    alias ll="eza -l --icons"            # Vista en lista detallada
    alias la="eza -la --icons"           # Muestra archivos ocultos
    alias lt="eza --tree --icons"        # Muestra el árbol de directorios
    alias llt="eza -l --tree --icons"    # Árbol con detalles
    alias lsg="eza -l --git --icons"     # Lista con estado de Git
else
    # Fallback to standard ls with colors
    if [[ "$IS_MAC" == true ]]; then
        alias ls='ls -G'
        alias ll='ls -lG'
        alias la='ls -laG'
    else
        alias ls='ls --color=auto'
        alias ll='ls -l --color=auto'
        alias la='ls -la --color=auto'
    fi
fi

# ===== Python Aliases =====
# .gitignore for Python projects
alias addpyignore='curl -s https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore -o .gitignore'
# Monta entorno virtual
alias vnv='source .venv/bin/activate'

# ===== Claude Aliases =====
alias cld='claude'
alias cldp='claude -p'
alias cldy='claude --dangerously-skip-permissions'
alias cldyh='claude --dangerously-skip-permissions --model haiku'
alias cldys='claude --dangerously-skip-permissions --model sonnet'
alias cldyo='claude --dangerously-skip-permissions --model opus'

# ===== Alert Alias =====
if [[ "$IS_LINUX" == true ]]; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# ===== ZSH PLUGINS =====

# Autosuggestions - sugiere comandos mientras escribes basándose en el historial
if [[ "$IS_LINUX" == true ]]; then
    # Linux (Debian/Ubuntu path)
    if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
elif [[ "$IS_MAC" == true ]]; then
    # macOS (Homebrew path)
    if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    elif [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
fi

# Configure autosuggestions if loaded
if (( $+functions[_zsh_autosuggest_start] )); then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    # Acepta sugerencia con Ctrl+Space
    bindkey '^ ' autosuggest-accept
fi

# Syntax Highlighting - colorea la sintaxis de los comandos
if [[ "$IS_LINUX" == true ]]; then
    # Linux (Debian/Ubuntu path)
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
elif [[ "$IS_MAC" == true ]]; then
    # macOS (Homebrew path)
    if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    elif [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
fi

# ===== FZF CONFIGURATION =====

# FZF key bindings and fuzzy completion
if [[ "$IS_LINUX" == true ]]; then
    # Linux paths
    if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
    fi
    if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
        source /usr/share/doc/fzf/examples/completion.zsh
    fi
elif [[ "$IS_MAC" == true ]]; then
    # macOS paths (Homebrew)
    if [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]; then
        source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    elif [ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]; then
        source /usr/local/opt/fzf/shell/key-bindings.zsh
    elif [ -f ~/.fzf.zsh ]; then
        source ~/.fzf.zsh
    fi

    if [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]; then
        source /opt/homebrew/opt/fzf/shell/completion.zsh
    elif [ -f /usr/local/opt/fzf/shell/completion.zsh ]; then
        source /usr/local/opt/fzf/shell/completion.zsh
    fi
fi

# FZF default options
export FZF_DEFAULT_OPTS='
    --height 40%
    --layout=reverse
    --border
    --inline-info
    --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
    --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
    --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
    --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

# Use fd or find for better file search
if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
else
    export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.git/*"'
fi

# FZF-based cd into subdirectories (Alt-c ya viene por defecto)
# FZF-based command history (Ctrl-r ya viene por defecto)
# FZF-based file selection (Ctrl-t ya viene por defecto)

# ===== USEFUL KEYBINDINGS =====

# Ctrl-Left/Right para moverse por palabras
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# macOS también necesita estas variantes
if [[ "$IS_MAC" == true ]]; then
    bindkey '^[^[[C' forward-word
    bindkey '^[^[[D' backward-word
fi

# Ctrl-Backspace para borrar palabra anterior
bindkey '^H' backward-kill-word

# Home y End
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# macOS también necesita estas variantes
if [[ "$IS_MAC" == true ]]; then
    bindkey '^[[1~' beginning-of-line
    bindkey '^[[4~' end-of-line
fi

# Delete key
bindkey '^[[3~' delete-char

# ===== USEFUL OPTIONS =====

# Autocorrección de comandos
setopt CORRECT
setopt CORRECT_ALL

# Permite usar comodines extendidos
setopt EXTENDED_GLOB

# No guarda comandos duplicados consecutivos
setopt HIST_IGNORE_DUPS

# Comparte el historial entre todas las sesiones
setopt SHARE_HISTORY

# Agrega comandos al historial inmediatamente
setopt INC_APPEND_HISTORY

# Navegar por directorios sin cd
setopt AUTO_CD

# Pushd automático al cambiar de directorio
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# ===== ADDITIONAL USEFUL ALIASES =====

# Navegación rápida
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Suffix aliases - ejecuta archivos directamente según su extensión
alias -s ts='bun'
alias -s py='uv run'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'

# Búsqueda de procesos
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# Limpiar pantalla de verdad
alias cls='clear && printf "\e[3J"'
