set termguicolors

nnoremap <SPACE> <Nop>
let mapleader = " "

nnoremap U <C-R>


" PLUGBEGIN
call plug#begin()


Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'

"langs and syntax
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mboughaba/i3config.vim'
"end langs
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'liuchengxu/vim-which-key'
Plug 'chrisbra/Colorizer'
Plug 'phaazon/hop.nvim'
Plug 'vim-airline/vim-airline'
call plug#end()
" PLUGEND



let g:colorizer_auto_color = 1
let g:colorizer_skip_comments = 1
let g:colorizer_colornames = 0
autocmd BufEnter,BufLeave * ColorHighlight

" unbind recording
map q <Nop>

let g:vim_json_conceal=0

" hop
lua require'hop'.setup { keys = 'tnhesoairudpwf', term_seq_bias = 0.5 }

"vim-which-key
call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :<c-u>WhichKey '<space>'<CR>
vnoremap <silent> <leader>/ :<c-u>WhichKeyVisual ''<CR>
set timeoutlen=500

let g:which_key_map =  {}

let g:which_key_map.f = { 'name' : '+file' }
let g:which_key_map.n = { 'name' : '+clear' }

nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map.f.s = 'save-file'


let g:which_key_map.r = {'name': '+replace'}
vnoremap <leader>ra "hy:%sno%<C-r>h%%g<left><left>

let g:which_key_map.r.a = 'replace all'

vnoremap <leader>rc "hy:%sno%<C-r>h%%gc<left><left><left>
let g:which_key_map.r.c = 'replace with confirmation'

nnoremap <leader>nh :noh<CR>
let g:which_key_map.n.h = 'clear highlight'


nnoremap <leader>fd :GitFiles?<CR>
let g:which_key_map.f.d = 'show diff'

nnoremap " :HopWord<CR>

augroup filetype_rust
    autocmd!
    autocmd BufReadPost *.rs setlocal filetype=rust
augroup END


nnoremap <C-P> :FZF<CR>


" copy yanks to system clipboard
set clipboard+=unnamedplus

" Theme
syntax enable
colorscheme dracula


" Toggle filemanager
nnoremap <silent> <C-b> :Lex<CR>
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

set tabstop=4 expandtab shiftwidth=4  

set smartcase
set ignorecase

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


" for coc.nvim
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()

" Trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>oa  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>oe  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>oc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>oo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>os  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>oj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ok  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>op  :<C-u>CocListResume<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end




" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

nnoremap <silent> <leader>ff :Format<CR>
let g:which_key_map.f.f = 'format buffer'

