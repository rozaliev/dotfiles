


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
Plug 'rust-lang/rust.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()
" PLUGEND


augroup filetype_rust
    autocmd!
    autocmd BufReadPost *.rs setlocal filetype=rust
augroup END

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let $RUST_BACKTRACE = 1
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_virtualTextPrefix = ''
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

set hidden
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nnoremap <C-P> :FZF<CR>

" copy yanks to system clipboard
set clipboard+=unnamedplus

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
