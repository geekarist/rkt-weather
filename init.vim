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
Plug 'https://github.com/thaerkh/vim-workspace'
call plug#end()

" Plugin options
"let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let g:AutoPairs={'(':')', '[':']', '{':'}','"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let g:workspace_autocreate = 1

" Vim options
let guifont='Menlo_Regular:h16'
set shellslash
set tabstop=4
set softtabstop
set clipboard=unnamed
set mouse=a

" Mappings
let maplocalleader=";"
map <LocalLeader>p :FZF<Return>
map <LocalLeader>ec :tabnew ~/AppData/Local/nvim/init.vim<Return>
map <LocalLeader><LocalLeader> :map <LocalLeader><Return>
map <Leader><Leader> :map <Leader><Return>

colorscheme onedark

