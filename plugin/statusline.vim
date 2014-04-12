let g:normaltermcols = 'ctermfg=254 ctermbg=33 cterm=NONE'
let g:inserttermcols = 'ctermfg=235 ctermbg=64 cterm=bold'
let g:replacetermcols = 'ctermfg=254 ctermbg=160 cterm=bold'
let g:visualtermcols = 'ctermfg=235 ctermbg=136 cterm=NONE'
let g:messagetermcols = 'ctermfg=37 ctermbg=235 cterm=NONE'

execute 'highlight User3 '.g:messagetermcols
execute 'highlight User2 '.g:messagetermcols

function! Mode()
    redraw
    let l:mode = mode()

    if mode ==# "n"
      execute 'highlight User1 '.g:normaltermcols
      execute 'highlight User9 '.g:normaltermcols
      return "NORMAL"
    elseif mode ==# "i"
      execute 'highlight User1 '.g:inserttermcols
      execute 'highlight User9 '.g:inserttermcols
      return "INSERT"
    elseif mode ==# "R"
      execute 'highlight User1 '.g:replacetermcols
      execute 'highlight User9 '.g:replacetermcols
      return "REPLACE"
    elseif mode ==# "v"
      execute 'highlight User1 '.g:visualtermcols
      execute 'highlight User9 '.g:visualtermcols
      return "VISUAL"
    elseif mode ==# "V"
      execute 'highlight User1 '.g:visualtermcols
      execute 'highlight User9 '.g:visualtermcols
      return "V-LINE"
    elseif mode ==# ""
      execute 'highlight User1 '.g:visualtermcols
      execute 'highlight User9 '.g:visualtermcols
      return "V-BLOCK"
    else
      return l:mode
    endif
endfunc

if has('statusline')
    let &statusline=
       \ '%1*'.' %{Mode()} '
       \.'%0*'.' %<%F '
       \.'%2*'.'%( %M %{&modified ? "modified" : ""} %)'.'%( %R %{&ro != 0 ? "readonly" : ""} %)'
       \.'%3*'.'%='
       \.'%0*'.'%( %{&filetype} %)'.'%( %{(&fenc!=""?&fenc:&enc)} %)'
       \.'%9*'.' %L %3p%% %4l:%4c '
endif

