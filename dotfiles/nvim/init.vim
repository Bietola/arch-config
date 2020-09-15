"" pathogen (RIP)
" execute pathogen#infect()

" plug init
call plug#begin('~/.local/share/nvim/plugged')

" plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'daveyarwood/vim-alda'
Plug 'calincru/flex-bison-syntax'
Plug 'ron-rs/ron.vim'
Plug 'AndrewRadev/dsf.vim'
Plug 'runoshun/vim-alloy'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'masukomi/vim-markdown-folding'
Plug 'rust-lang/rust.vim'
Plug 'tommcdo/vim-exchange'
Plug 'gyim/vim-boxdraw'
Plug 'kana/vim-tabpagecd'
Plug 'Raimondi/delimitMate'
Plug 'szw/vim-tags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'jpalardy/vim-slime'
Plug 'vim-scripts/DrawIt'
Plug 'AndrewRadev/sideways.vim'
" Plug 'Valloric/YouCompleteMe'
Plug 'majutsushi/tagbar'
Plug 'thaerkh/vim-workspace'
Plug 'godlygeek/tabular'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'

" programming languages
Plug 'suoto/vim-hdl'
Plug 'vim-perl/vim-perl6'
Plug 'quabug/vim-gdscript'
Plug 'sheerun/vim-polyglot'
"TODO Plug 'vim-syntastic/syntastic'

" colorschemes
Plug 'nightsense/carbonized'
Plug 'JarrodCTaylor/spartan'
Plug 'KKPMW/sacredforest-vim'
Plug 'cocopon/iceberg.vim'

" plug deinit
call plug#end()

" vimrc loading stuff
set exrc

" nvim :terminal suff
if has("nvim")
  tnoremap <ESC><ESC> <C-\><C-n>
  "! tnoremap jk <C-\><C-n> " RIP (need caps lock for ranger)
endif

" window splitting shortcuuts
noremap <C-w>V <C-w>v<C-w><C-l>
noremap <C-w>S <C-w>s<C-w><C-j>
noremap <C-j> <C-w>w
noremap <C-k> <C-w>W

" window splitting options
set diffopt+=vertical

" file loading stuff
:set autowriteall

" operating system detection variables
if !exists("g:os")
if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
else
    let g:os = substitute(system('uname'), '\n', '', '')
endif
endif

" operating system make configuration
if g:os == "Windows"
set makeprg=mingw32-make
elseif g:os == "Linux"
set makeprg=make
endif

" operating system cmake configurations
if g:os == "Windows"
command -bar -nargs=1 CMake !cmake -G "MinGW Makefiles" <args>
elseif g:os == "Linux"
command -bar -nargs=1 CMake !cmake  <args>
end

" operating system cmake debug configurations
if g:os == "Windows"
command -bar -nargs=1 DMake !cmake -DCMAKE_BUILD_TYPE=Debug -G "MinGW Makefiles" <args>
elseif g:os == "Linux"
command -bar -nargs=1 DMake !cmake -DCMAKE_BUILD_TYPE=Debug <args>
end

" operating system cmake vcpkg configurations
if g:os == "Linux"
command -bar -nargs=1 VCMake !cmake -DCMAKE_TOOLCHAIN_FILE=/usr/pkg/vcpkg/scripts/buildsystems/vcpkg.cmake <args>
end

" ctrl settings
let g:ctrlp_show_hidden = 1

" leader
let mapleader = "ò"

" useful mappings
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>
" tabularize quick mapping
nnoremap <leader>tab :Tabularize 
vnoremap <leader>tab :Tabularize 
" sideways mappings
nnoremap <leader>h :SidewaysLeft<CR>
nnoremap <leader>l :SidewaysRight<CR>
" vimrc management
" TODO: Make a boxes related plugin
au filetype vim vnoremap <leader>b :'<,'>!boxes -d vim-box<cr>
au filetype vim nnoremap <leader>bb V:'<,'>!boxes -d vim-box<cr>

" terminal looks
set background=dark
set termguicolors
colorscheme iceberg
noremap <leader>m :colorscheme morning<cr>
set guifont=Consolas:h17

" tab (those akin to windows...) settings and custom commands
au TabEnter * if exists("t:wd") | exe "cd" t:wd | endif
let g:airline_powerline_fonts = 1

" whitespace (tab/backspace) things
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

" default syntax
syntax on
set syntax=cpp
filetype plugin indent on

" default path
set path+=../**

" menu options
set wildmenu
set number

" no idea... (should research)
set timeoutlen=10000

" Sensible clipboard behaviour.
set clipboard=unnamedplus

" utility remappings
" imap jk <Esc> " RIP (need caps lock for ranger)

" utility commands
command W      set wrap!
command NoWar  set errorformat^=%-G%f:%l:\ warning:%m
command Tgen   cd .. | !ctags -R | cd build
command Comp   !g++ main.cpp -o Proj
command RCEdit edit $MYVIMRC

command Ex  !./Proj
command Tex !/usr/bin/time ./Proj 

"" netrw settings
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>

" TagBar settings
" TODO: nmap <leader><leader> :TagbarToggle<CR><c-w><c-w>

" vim-slime options
let g:slime_target = "neovim"

" delimitMate options
let delimitMate_expand_cr = 1

" markdown mappings  
nnoremap <leader>ft :TableFormat<CR>

" surround mappings and custom settings
nmap s ys
au FileType lilypond let b:surround_45 = "<< \r >>"

" markdown settings  
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_enable_folding = 1

" vim-pandoc settings
"" let g:pandoc#syntax#codeblocks#embeds#langs = ["cpp"]
"let g:pandoc#folding#fold_fenced_codeblocks = 1

" gabrielelana markdown settings
" let g:markdown_enable_folding = 1

" mkdx configuration
" let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
"                         \ 'enter': { 'shift': 1 },
"                         \ 'links': { 'external': { 'enable': 1 } },
"                         \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
"                         \ 'fold': { 'enable': 1 } }
" let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
"                                       " plugin which unfortunately interferes with mkdx list indentation.

" default formatting settings
set expandtab
set tabstop=4
set shiftwidth=4
set sts=4
set autoindent

" tagbar settings for perl6
let g:tagbar_type_perl6 = {
  \ 'ctagstype' : 'perl6',
  \ 'kinds' : [
    \ 'c:classes',
    \ 'g:grammar',
    \ 'm:methods',
    \ 'o:modules',
    \ 'p:packages',
    \ 'r:roles',
    \ 'u:rules',
    \ 'b:submethods',
    \ 's:subroutines',
    \ 't:tokens'
  \ ]
\ }

" c and cpp formatting settings
au FileType cpp,c set expandtab
au FileType cpp,c set tabstop=4
au FileType cpp,c set shiftwidth=4
au FileType cpp,c set sts=4
au FileType cpp,c set autoindent

" MIPS formatting settings
au FileType asm set expandtab
au FileType asm set tabstop=8
au FileType asm set shiftwidth=8
au FileType asm set sts=8
au FileType asm set autoindent

" basic formatting settings
au FileType basic let b:delimitMate_quotes = "\""

" lisp formatting settings
au FileType lisp let b:delimitMate_quotes = "\""
au FileType lisp set expandtab
au FileType lisp set tabstop=2
au FileType lisp set shiftwidth=2

" racket formatting settings
au FileType racket let b:delimitMate_quotes = "\""

"asdf formatting settings
au BufRead,BufNewFile *.asd set filetype=lisp

" python3 formatting settings
au FileType python set expandtab
au FileType python set tabstop=4
au FileType python set shiftwidth=4
au FileType python set sts=4
au FileType python set autoindent

"""""""""""""""""""""""""""""
" Utility terminal commands "
"""""""""""""""""""""""""""""

nnoremap <leader>to <C-W>o<C-W>j:term<cr>
nnoremap <leader>tv <C-W>v<C-W>l:term<cr>
nnoremap <leader>tw <leader>to
nnoremap <leader>tt :tabnew<cr>:term<cr>
" TODO: Make this cross-compatible with all terminals by using
" ~/bin/spawn-term
nnoremap <leader>tp :!"$TERMINAL" --working-directory "$PWD" &<cr>
nnoremap <leader>tn :tabnew<cr>

" Quickly navigate to previous prompt
nnoremap <leader>p /^[dincio@dincio<cr>G$NN

" quick vimgrep command
command -nargs=1 Vimgrep vimgrep <args> ##
" NB: this initialization is customized for different languages
au filetype c,cpp nnoremap <leader>vi :args ./**<cr>
au filetype c,cpp nnoremap <leader>vg :Vimgrep 
au filetype c,cpp nnoremap <leader>v/ :Vimgrep ///g<cr>

" Lilypond general keybindings
" Compile current file
au filetype lilypond nnoremap <leader>c :w<cr>:!lilypond %<cr>
" View pdf associated with current file
au filetype lilypond nnoremap <leader>v :!zathura %:r.pdf &<cr>
" play selected notes
au filetype lilypond nnoremap <leader>P :set opfunc=LyPlay<CR>g@
" TODO: vmap <silent> <F4> :<C-U>call CountSpaces(visualmode(), 1)<CR>
" function to do heavy lifting
function! LyPlay(type)
    " Get notes specified by the motion
    if a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    " Play them
    let lycommand = "!lyplay italiano do \"<->\""
    let lycommand = substitute(lycommand, "<->", @@, "")
    exe lycommand
endfunction


"""""""""""""""""""""""""""
" LSP default keybindings "
"""""""""""""""""""""""""""

nnoremap <leader>hv :LspHover<cr>
nnoremap <leader>rf :LspReference<cr>
noremap <leader>rn :LspRename<cr>
noremap <leader>fm :LspDocumentFormat<cr>
noremap <leader>er :LspDocumentDiagnostics<cr>
noremap <leader>gd :LspDefinition<cr>
noremap <leader>gr :LspReferences<cr>

" Boxes comments
vnoremap <leader>b :'<,'>!boxes<cr>
nnoremap <leader>bb V:'<,'>!boxes<cr>
nnoremap <leader>bm vip:'<,'>!boxes -m<cr>

"""""""""
" Shell "
"""""""""

au filetype sh vnoremap <leader>b :'<,'>!boxes -d shell<cr>
au filetype sh nnoremap <leader>bb V:'<,'>!boxes -d shell<cr>
au filetype sh nnoremap <leader>bm vip:'<,'>!boxes -d shell -m<cr>

""""""""
" Rust "
""""""""

" Cargo
au filetype rust nnoremap <leader><leader>r :!cargo run<cr>
au filetype rust nnoremap <leader><leader>t :!cargo test<cr>

" Boxes
au filetype rust vnoremap <leader>b :'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bb V:'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bm vip:'<,'>!boxes -m<cr>
au filetype rust nnoremap <leader>vg :Vimgrep 

" Formatting (LspDocumentFormat does not work...)
au filetype rust nnoremap <leader>fm :RustFmt<cr>

" Other useful keybindings
au filetype rust nnoremap <leader>vi :args src/**<cr>

"""""
" C "
"""""
au filetype c inoremap <c-c> <esc>:!gcc main.c<cr>i

""""""""""
" Racket "
""""""""""

" Slime
au filetype racket nnoremap <leader>tt :vsp<cr>:term racket<cr>:echo b:terminal_job_id<cr><c-w><c-l>
au filetype racket nnoremap <leader>fm :LspDocumentFormat<cr>

"""""""""""
" Haskell "
"""""""""""

" Terminal utility mappings
nnoremap <leader>P /^Prelude<cr>G$NN

" Auto-formatter/Prettifier
au filetype haskell nnoremap <leader>fm :!hindent %<cr>:e<cr>
au filetype haskell vnoremap <leader>fm :!hindent<cr>

" Comments
au filetype haskell vnoremap <leader>b :'<,'>!boxes -d ada-box<cr>
au filetype haskell vnoremap <leader>bm V:'<,'>!boxes -m<cr>
au filetype haskell nnoremap <leader>bb V:'<,'>!boxes -d ada-box<cr>

" Slime
au filetype haskell nnoremap <leader>trw :vsp<cr>:term ghci<cr>:echo b:terminal_job_id<cr><c-w><c-l>
au filetype haskell nnoremap <leader>trt :tabnew<cr>:term ghci<cr>:echo b:terminal_job_id<cr>gT

" Tabular
au filetype haskell nnoremap <leader>t= :Tabular /=<cr>

""""""""""
" Scheme "
""""""""""

" Mistery command...
" TODO: Understand what it does...
nnoremap <leader>a mmggVG:SlimeSend<cr>'m

"""""""""
" Lance "
"""""""""
" NB. Lance is an educational language for the Formal Languages course at Polimi

autocmd FileType lance set syntax = lua

""""""""""""""""
" Git Fugitive "
""""""""""""""""

" Custom commands
function GAddAndGit()
    :Git A
    :Git
endfunction
command A exec GAddAndGit()

""""""""""
" Ranger "
""""""""""

" Open ranger when vim open a directory
let g:ranger_replace_netrw = 1 

""""""""""""""""
" Coc settings "
""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
