set nocompatible
set nocp
runtime plugin/listtrans.vim
runtime plugin/SWTC.vim
filetype plugin on

highlight Comment term=bold ctermfg=white

augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

if has('persistent_undo')
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    set undolevels=5000
    set undofile
endif

autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|  endif

highlight WhiteOnRed ctermbg=red ctermfg=white
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
set tabstop=4

"syntax on
syntax on

nnoremap <silent> n n:call HLNext(0.2)<cr>
nnoremap <silent> N N:call HLNext(0.2)<cr>

"=====[ Highlight the match in red ]=============
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

nmap ;l :call ListTrans_ToggleFormat()<CR>
vmap ;l :call ListTrans_ToggleFormat('visual')<CR>
