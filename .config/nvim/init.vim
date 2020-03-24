


" PLUGBEGIN
call plug#begin()


Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

"langs
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
"end langs
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'liuchengxu/vim-which-key'
call plug#end()

" PLUGEND

let g:vim_json_conceal=0

"vim-which-key
let g:which_key_map =  {}

nnoremap <silent> <leader> :<c-u>WhichKey '\'<CR>
nnoremap <silent> <leader>/ :<c-u>WhichKey ''<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '\'<CR>
vnoremap <silent> <leader>/ :<c-u>WhichKeyVisual ''<CR>
set timeoutlen=500

let g:which_key_map['\'] = { 'name' : '<leader>' }
let g:which_key_map['\'].f = { 'name' : '+file' }

nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map['\'].f.s = 'save-file'


let g:which_key_map['\'].r = {'name': '+replace'}
vnoremap <leader>ra "hy:%sno%<C-r>h%%g<left><left>

let g:which_key_map['\'].r.a = 'replace all'

vnoremap <leader>rc "hy:%sno%<C-r>h%%gc<left><left><left>
let g:which_key_map['\'].r.c = 'replace with confirmation'


augroup filetype_rust
    autocmd!
    autocmd BufReadPost *.rs setlocal filetype=rust
augroup END

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let $RUST_BACKTRACE = 1
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_virtualTextPrefix = ''
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

set hidden
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

let g:which_key_map.g = {'name': '+goto'}
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
let g:which_key_map.g.d = 'go o definition'

nnoremap <silent> <leader>ff :call LanguageClient#textDocument_formatting()<CR>

let g:which_key_map['\'].f.f = 'format file'

nnoremap <C-P> :FZF<CR>


" copy yanks to system clipboard
set clipboard+=unnamedplus

" Tab nav for deoplete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Enable theming support
if (has("termguicolors"))
	set termguicolors
endif

" Theme
syntax enable
colorscheme dracula


" Nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" deoplete
let g:deoplete#enable_at_startup = 1


set tabstop=4 expandtab shiftwidth=4  


let g:rustfmt_autosave = 1


set number relativenumber
set nu rnu

" IndentLine
let g:indentLine_color_term = 239
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·' 

"No mode line
set noshowmode

"NerdCommenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1


call which_key#register('', "g:which_key_map")
let g:which_key_map_leader = g:which_key_map['\']
call which_key#register('\', "g:which_key_map_leader")
