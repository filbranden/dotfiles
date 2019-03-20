
" if terminal identifies as xterm but $COLORTERM is set, then we've got rich colors
if (&term ==# "xterm" || &term ==# "screen") && !empty($COLORTERM)
  let &t_Co = 256
endif

let g:airline_powerline_fonts = 1

" Set up vim-plug
call plug#begin()

Plug 'junegunn/vim-plug'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'sgur/vim-editorconfig'
Plug 'vim-airline/vim-airline'
Plug 'lifepillar/vim-colortemplate'
Plug 'ludovicchabant/vim-gutentags'
" Color schemes:
Plug 'altercation/vim-colors-solarized'
Plug 'filbranden/vim-colorscheme'

call plug#end()

" use my own colorscheme for dark colors
set background=dark
colorscheme subtle_wip

" don't wrap lines
set nowrap

" for when splitting screen
set splitbelow
set splitright

" tab-expansion of filenames: complete till longest string, then open wildmenu.
set wildmode=longest,full

" use Ctrl+E (in insert mode) to enter/leave paste mode
"set pastetoggle=<C-e>
inoremap <C-e> <C-g>u<C-o>:normal <Plug>unimpairedPaste<cr>

" show tabs and trailing spaces, also when line continues
set list
let &listchars = "tab:\ubb ,trail:\ub7,extends:\ubb,precedes:\uab"

" I'm using Ctrl-X for tmux, but I miss it for completion (check :help i_CTRL-X)
" Thankfully, Ctrl-Y (copy from line above) is useless so I can take it instead!
inoremap <C-y> <C-x>
" also map the most useful completions (file, line and tags)
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>
inoremap <C-]> <C-x><C-]>

" window movement
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l
" Ctrl-W twice to go to the last accessed windows (instead of rotating)
nnoremap <C-W><C-W> <C-W>p

" my autocmds here:
augroup filbranden_vimrc
  autocmd!
  " for Vim files: don't add comments by default when typing return
  autocmd FileType vim setlocal formatoptions-=r formatoptions-=o expandtab softtabstop=2 shiftwidth=2
  " When restoring tmux, resize windows to equal size
  autocmd VimResized * wincmd =
augroup END

