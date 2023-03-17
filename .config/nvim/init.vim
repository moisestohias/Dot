set guifont=JetBrains\ Mono:h22

" Pluggins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Plug 'wfxr/minimap.vim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Somewhere after plug#end()
" lua require('Comment').setup()

" KeyBindings
nnoremap <A-n> :set nu rnu
nnoremap <A-S-n> :set nonu nornu

" !Note: the exclamation mark prevents them from being associated with any current mappings.
nnoremap j gj  # or: nnoremap j :normal! gj<CR> nnoremap gj j  # or: nnoremap k :normal! gk<CR> nnoremap k gk  # or: nnoremap gj :normal! j<CR> nnoremap gk k  # or: nnoremap gk :normal! k<CR>

vnoremap j gj
vnoremap gj j
vnoremap k gk
vnoremap gk k


" To solve the problem of also jumping with visual lines you can use: 
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" xclip must be installed "sai xclip"
" vnoremap <C-x> :!xclip -f -sel clip<CR>
" map <C-v> :-1r !xclip -o -sel clip<CR>
vnoremap <C-x> "+y
" nnoremap <C-v> "+P
" vnoremap <C-c> "+y
" nmap cp :let @+ = expand("%")<CR>
" vnoremap <C-c> "*y :let @+=@*<CR>

" Thmeing
" Highlight current line
" set cursorline " this will just enable basic underline, the following is for changing the theme.
" hi CursorColumn cterm=NONE ctermbg=0A0809 ctermfg=white guibg=0A0809 guifg=white
" hi CursorLine   cterm=NONE ctermbg=0A0809 ctermfg=white guibg=0A0809 guifg=white
" hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR> 

set termguicolors 
" set winblend
" set wildoptions = 'pum'
" set pumblend = 5
" set background = 'dark'
" set clipboard=unnamedplus,unnamed

" set shell=xterm-kitty "This cause the issue of not being able to :read 
set nonumber
set textwidth=0 " This effectively the auto-wrap line, '0' disable auto-wrap
" 0 means use wrap margin value to auto wrap newlly pasted line longer than wrap marging. 
set wrapmargin=0 "-NotUseful-MustBe0-#OfChars from the right window border to wrap 
set wrap linebreak "wrap 'linebreak': means the line should wrap only between words. 
set breakindent " 'bool' whether or not to indent subsequent wrapped lines 
" set breakindentopt=shift:1,min:40,sbr
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set linebreak
set encoding=utf-8
set spelllang=eng
set history=1000
set nobackup
set nowritebackup 
set noswapfile 
set fileencodings=utf-8

" set nocompatible
" filetype plugin indent on
" syntax enable

set autoread
set backspace=2
set browsedir=buffer
set fileformats=unix,dos,mac
set foldmethod=marker
set formatprg=par
set hidden
set ignorecase
set incsearch
set laststatus=1
set list
set listchars=tab:▸\ ,eol:¬
set mouse=a
set noequalalways
set nohlsearch
set nojoinspaces
set omnifunc=syntaxcomplete#Complete
set path+=**

set showcmd
" set shortmess=filnxtToOI
" set splitbelow
" set splitright
" set smartcase
" set smartindent
" set timeoutlen=600
" set ttyfast
" set visualbell t_vb=".
" set wildcharm=<C-z>
" set wildignorecase
" set wildmenu
" set wildmode=longest,list

" Necessary order
" set display=lastline




" nv.conf
if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:gui_font_size = 22

    let g:neovide_fullscreen=v:false
    let g:neovide_no_idle=v:false
    let g:neovide_hide_mouse_when_typing = v:false
    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0
    let g:neovide_cursor_animation_length=0.13

    let g:neovide_transparency=0.86
    function! ChangeTransparency(delta)
      let g:neovide_transparency = g:neovide_transparency + a:delta
    endfunction
    nnoremap <expr> <C-up> ChangeTransparency(0.1)
    nnoremap <expr> <C-down> ChangeTransparency(-0.1)

    " silent! execute('set guifont=Menlo:h'.g:gui_font_size)
    function! ResizeFont(delta)
      let g:gui_font_size = g:gui_font_size + a:delta
      execute('set guifont=JetBrains\ Mono:h'.g:gui_font_size)
    endfunction
    noremap <expr><C-S-up> ResizeFont(1)
    noremap <expr><C-S-down> ResizeFont(-1)
endif


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


let g:minimap_auto_start = 0
let g:minimap_width = 10
" let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
