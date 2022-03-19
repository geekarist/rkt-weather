" Plugins
set noshellslash
call plug#begin('~/.vim/autoload')
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/wlangstroth/vim-racket'
Plug 'Olical/conjure'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'jiangmiao/auto-pairs'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'https://github.com/mattn/vim-findroot'
"Plug 'https://github.com/ctrlpvim/ctrlp.vim'
"Plug 'mhinz/vim-startify'
call plug#end()

" Plugin options
"let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let g:AutoPairs={'(':')', '[':']', '{':'}','"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let g:workspace_autocreate = 1
"let g:startify_session_persistence = 1

" Vim options
let guifont='Menlo_Regular:h16'
set shellslash
set tabstop=4
set softtabstop
set clipboard=unnamed
set mouse=a

" Personal mappings
map ;; :map ;<Return>
map ;p :FZF<Return>
map ;ec :tabnew ~/AppData/Local/nvim/init.vim<Return>

" Mappings
map <Leader><Leader> :map <Leader><Return>

colorscheme onedark

