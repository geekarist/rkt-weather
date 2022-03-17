" Plugins
set noshellslash
call plug#begin('~/.vim/autoload')
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/wlangstroth/vim-racket'
Plug 'Olical/conjure'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'https://github.com/mattn/vim-findroot'
call plug#end()

" Vim options
let guifont='Menlo_Regular:h16'
set shellslash
set tabstop=4
set softtabstop
set clipboard=unnamed

" Mappings
map <Leader>p :FZF<Return>

colorscheme onedark

" Plugin options
"let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let g:AutoPairs={'(':')', '[':']', '{':'}','"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

