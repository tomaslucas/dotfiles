" ============================================================================
" General Settings
" ============================================================================

" Enable syntax highlighting
syntax enable

" Set encoding
set encoding=utf-8

" Enable filetype detection and plugins
filetype plugin indent on

" ============================================================================
" User Interface
" ============================================================================

" Show line numbers (hybrid mode: absolute + relative)
set number
set relativenumber

" Highlight current line
set cursorline

" Show command in bottom bar
set showcmd

" Visual autocomplete for command menu
set wildmenu
set wildmode=longest:full,full

" Show matching brackets
set showmatch

" Always show status line
set laststatus=2

" Show cursor position
set ruler

" Enable mouse support
set mouse=a

" ============================================================================
" Indentation & Formatting
" ============================================================================

" Tabs are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Convert tabs to spaces
set expandtab

" Smart indentation
set autoindent
set smartindent

" ============================================================================
" Search Settings
" ============================================================================

" Highlight search results
set hlsearch

" Incremental search
set incsearch

" Ignore case when searching
set ignorecase

" Override ignorecase if search pattern contains uppercase
set smartcase

" ============================================================================
" Performance & Files
" ============================================================================

" Reduce updatetime for better performance
set updatetime=300

" Don't create backup files
set nobackup
set nowritebackup

" Don't use swap files (they're annoying)
set noswapfile

" Persistent undo
set undofile
set undodir=~/.vim/undodir

" Auto-reload files changed outside vim
set autoread

" ============================================================================
" Editing Behavior
" ============================================================================

" Better backspace behavior
set backspace=indent,eol,start

" Don't wrap lines
set nowrap

" Keep cursor centered when scrolling
set scrolloff=8

" Enable clipboard integration
set clipboard=unnamed

" ============================================================================
" Language Specific
" ============================================================================

" Python syntax highlighting
let python_highlight_all = 1

" ============================================================================
" Key Mappings (Optional - uncomment if desired)
" ============================================================================

" Clear search highlighting with <Space>
nnoremap <Space> :noh<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
