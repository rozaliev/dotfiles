set termguicolors

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
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'liuchengxu/vim-which-key'
Plug 'chrisbra/Colorizer'
Plug 'vim-airline/vim-airline'
call plug#end()
" PLUGEND



let g:colorizer_auto_color = 1
let g:colorizer_skip_comments = 1
let g:colorizer_colornames = 0
autocmd BufEnter,BufLeave * ColorHighlight

" unbind recording
map q <Nop>

" rebind undo from 'u' to "<leader>u'
map u <Nop>
map U <Nop>
map <leader>u <Undo>

let g:vim_json_conceal=0

"vim-which-key
let g:which_key_map =  {}

nnoremap <silent> <leader> :<c-u>WhichKey '\'<CR>
nnoremap <silent> <leader>/ :<c-u>WhichKey ''<CR>
nnoremap <silent> <space> :<c-u>WhichKey '<space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '\'<CR>
vnoremap <silent> <leader>/ :<c-u>WhichKeyVisual ''<CR>
vnoremap <silent> <space> :<c-u>WhichKeyVisual '<space>'<CR>
set timeoutlen=500

let g:which_key_map['\'] = { 'name' : '<leader>' }
let g:which_key_map['\'].f = { 'name' : '+file' }
let g:which_key_map['\'].n = { 'name' : '+clear' }

nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map['\'].f.s = 'save-file'


let g:which_key_map['\'].r = {'name': '+replace'}
vnoremap <leader>ra "hy:%sno%<C-r>h%%g<left><left>

let g:which_key_map['\'].r.a = 'replace all'

vnoremap <leader>rc "hy:%sno%<C-r>h%%gc<left><left><left>
let g:which_key_map['\'].r.c = 'replace with confirmation'

nnoremap <leader>nh :noh<CR>
let g:which_key_map['\'].n.h = 'clear highlight'


nnoremap <leader>fd :GitFiles?<CR>
let g:which_key_map['\'].f.d = 'show diff'

augroup filetype_rust
    autocmd!
    autocmd BufReadPost *.rs setlocal filetype=rust
augroup END


let g:which_key_map.g = {'name': '+goto'}

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
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


nnoremap <silent> <leader>ff :Format<CR>
let g:which_key_map['\'].f.f = 'format buffer'

call which_key#register('', "g:which_key_map")
let g:which_key_map_leader = g:which_key_map['\']
call which_key#register('\', "g:which_key_map_leader")
