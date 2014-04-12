if exists(':JSH')
  finish
endif

let s:jshint_command = 'jshint'
let s:jshint_read = 0
let s:jshint_save = 0
let s:jshint_close = 1
let s:jshint_confirm = 1
let s:jshint_color = 1
let s:jshint_error = 1
let s:jshint_height = 10
let s:config = '.jshintrc'
let s:arguments = '--reporter='.shellescape(expand('<sfile>:p:h').'/jshint.js')

function s:Command()
  let l:path = expand('%:p:h')

  while 1
    let l:config = l:path.'/'.s:config

    let l:found = filereadable(l:config)
    if l:found
      break
    endif

    let l:parent = fnamemodify(l:path, ':h')

    if l:path == l:parent
      break
    endif

    let l:path = l:parent
  endwhile

  return s:jshint_command.(l:found ? ' --config='.shellescape(l:config) : '').' '.s:arguments.' '.'/dev/stdin'
endfunction

function s:Echo(type, message)
  if s:jshint_color
    execute 'echohl '.a:type.'Msg'
  endif

  echo a:message

  if s:jshint_color
    echohl None
  endif
endfunction

function s:Trim(str)
  return substitute(substitute(a:str, '[\n\r]\|\s\{2,\}', ' ', 'g'), '^\s\+\|\s\+$', '', 'g')
endfunction

function s:Lint(start, stop, show, flags)
  if &buftype == 'quickfix' && !exists('b:jshint_buffer') || &buftype == 'help'
    return
  endif

  let l:buffer = exists('b:jshint_buffer') ? b:jshint_buffer : bufnr('%')
  let l:lines = getbufline(l:buffer, a:start, a:stop)
  let l:hashbang = l:lines[0] == '#!/usr/bin/env node'

  if s:jshint_confirm && &filetype != 'javascript' && !l:hashbang &&
      \ !exists('b:jshint_flags') && !exists('b:jshint_buffer')
    if confirm('Current file is not JavaScript, lint it anyway?', '&Yes'."\n".'&No', 1, 'Question') == 1
      redraw
    else
      return
    endif
  endif

  if !executable(s:jshint_command)
    return s:Echo('Error', 'JSHint is not executable, check if “'.s:Trim(s:jshint_command).'” callable from your terminal.')
  endif

  let b:jshint_flags = a:flags
  let l:flags = len(a:flags) ? '//jshint '.join(a:flags, ', ') : ''

  if l:hashbang
    let l:lines[0] = ''
  endif

  let l:report = system(s:Command(), join(insert(l:lines, l:flags), "\n"))

  if v:shell_error
    return s:Echo('Error', 'JSHint returns shell error “'.s:Trim(l:report).'”.')
  endif

  let l:matrix = map(map(split(l:report, "\n"), 'split(v:val, "\t")'),
    \ '{''bufnr'': '.l:buffer.', ''lnum'': str2nr(v:val[0] + a:start), ''col'': str2nr(v:val[1]),
      \ ''text'': v:val[2]'.(s:jshint_error ? ', ''type'': v:val[3], ''nr'': str2nr(v:val[4])' : '').'}')

  call setloclist(0, l:matrix, 'r')

  let l:ignored = len(filter(copy(a:flags), 'v:val =~ ''^-[EWI][0-9]\{3\}$''')) ? ' Some messages are ignored.' : ''

  lclose

  let l:length = len(l:matrix)

  if l:length
    call s:Echo('Warning', 'JSHint found '.(l:length == 1 ? '1 error' : l:length.' errors').'.'.l:ignored.
      \ substitute(matchstr(matchstr(l:matrix[-1].text, ' (\d\+% scanned)'), '\d\+'), '\d\+',
        \ ' About &% of file scanned.', ''))

    if a:show
      execute 'belowright lopen '.s:jshint_height
    endif
  else
    call s:Echo('More', 'JSHint did not find any errors.'.l:ignored)
  endif
endfunction

let s:completion = {
  \ 'asi': ['true', 'false'],
  \ 'bitwise': ['true', 'false'],
  \ 'boss': ['true', 'false'],
  \ 'browser': ['true', 'false'],
  \ 'camelcase': ['true', 'false'],
  \ 'couch': ['true', 'false'],
  \ 'curly': ['true', 'false'],
  \ 'debug': ['true', 'false'],
  \ 'devel': ['true', 'false'],
  \ 'dojo': ['true', 'false'],
  \ 'eqeqeq': ['true', 'false'],
  \ 'eqnull': ['true', 'false'],
  \ 'es3': ['true', 'false'],
  \ 'es5': ['true', 'false'],
  \ 'esnext': ['true', 'false'],
  \ 'evil': ['true', 'false'],
  \ 'expr': ['true', 'false'],
  \ 'forin': ['true', 'false'],
  \ 'funcscope': ['true', 'false'],
  \ 'gcl': ['true', 'false'],
  \ 'globalstrict': ['true', 'false'],
  \ 'immed': ['true', 'false'],
  \ 'indent': [2, 4, 8, 'false'],
  \ 'iterator': ['true', 'false'],
  \ 'jquery': ['true', 'false'],
  \ 'lastsemic': ['true', 'false'],
  \ 'latedef': ['nofunc', 'true', 'false'],
  \ 'laxbreak': ['true', 'false'],
  \ 'laxcomma': ['true', 'false'],
  \ 'loopfunc': ['true', 'false'],
  \ 'maxcomplexity': [4, 6, 8, 'false'],
  \ 'maxdepth': [4, 6, 8, 'false'],
  \ 'maxerr': [25, 50, 100, 'false'],
  \ 'maxlen': [64, 128, 256, 512, 'false'],
  \ 'maxparams': [4, 6, 8, 'false'],
  \ 'maxstatements': [4, 6, 8, 'false'],
  \ 'mootools': ['true', 'false'],
  \ 'moz': ['true', 'false'],
  \ 'multistr': ['true', 'false'],
  \ 'newcap': ['true', 'false'],
  \ 'noarg': ['true', 'false'],
  \ 'node': ['true', 'false'],
  \ 'noempty': ['true', 'false'],
  \ 'nomen': ['true', 'false'],
  \ 'nonew': ['true', 'false'],
  \ 'nonstandard': ['true', 'false'],
  \ 'onecase': ['true', 'false'],
  \ 'onevar': ['true', 'false'],
  \ 'passfail': ['true', 'false'],
  \ 'phantom': ['true', 'false'],
  \ 'plusplus': ['true', 'false'],
  \ 'proto': ['true', 'false'],
  \ 'prototypejs': ['true', 'false'],
  \ 'quotmark': ['single', 'double', 'true', 'false'],
  \ 'regexdash': ['true', 'false'],
  \ 'regexp': ['true', 'false'],
  \ 'rhino': ['true', 'false'],
  \ 'scripturl': ['true', 'false'],
  \ 'shadow': ['true', 'false'],
  \ 'shelljs': ['true', 'false'],
  \ 'smarttabs': ['true', 'false'],
  \ 'strict': ['true', 'false'],
  \ 'sub': ['true', 'false'],
  \ 'supernew': ['true', 'false'],
  \ 'trailing': ['true', 'false'],
  \ 'typed': ['true', 'false'],
  \ 'undef': ['true', 'false'],
  \ 'unused': ['vars', 'strict', 'true', 'false'],
  \ 'validthis': ['true', 'false'],
  \ 'white': ['true', 'false'],
  \ 'withstmt': ['true', 'false'],
  \ 'worker': ['true', 'false'],
  \ 'wsh': ['true', 'false'],
  \ 'yui': ['true', 'false']
\ }

function s:Complete(arg, cmd, ...)
  let l:colon = stridx(a:arg, ':')

  if l:colon == -1
    let l:flags = map(filter(split(a:cmd, '\s\+'), 'stridx(v:val, '':'') > -1'), 'v:val[: stridx(v:val, '':'') - 1]')

    return filter(keys(s:completion), 'index(l:flags, v:val) == -1 && v:val =~ ''^''.a:arg[: -1]')
  endif

  let l:flag = a:arg[: l:colon - 1]
  let l:value = a:arg[l:colon + 1 :]

  return has_key(s:completion, l:flag) ?
    \ sort(map(filter(copy(s:completion[l:flag]), 'v:val =~ ''^''.l:value'), 'l:flag.'':''.v:val')) : []
endfunction

let s:shortcuts = [{
  \ 'key': 't',
  \ 'info': 'open error in new tab',
  \ 'exec': '<C-W><CR><C-W>T'
\ }, {
  \ 'key': 'v',
  \ 'info': 'open error in new vertical split',
  \ 'exec': '<C-W><CR><C-W>L<C-W>='
\ }, {
  \ 'key': 's',
  \ 'info': 'open error in new horizontal split',
  \ 'exec': '<C-W><CR><C-W>='
\ }, {
  \ 'key': 'i',
  \ 'info': 'ignore selected error',
  \ 'exec': ':call <SID>Ignore()<CR>'
\ }, {
  \ 'key': 'n',
  \ 'info': 'scroll to selected error',
  \ 'exec': '<CR><C-W>p'
\ }, {
  \ 'key': 'q',
  \ 'info': 'close error list',
  \ 'exec': ':lclose<CR>'
\ }]

function s:Map()
  let l:errors = getloclist(0)

  if !len(l:errors)
    return
  endif

  let l:flags = getbufvar(l:errors[0].bufnr, 'jshint_flags')

  if type(l:flags) != type([])
    return
  endif

  execute 'setlocal statusline=[JSHint\ Error\ List]\ '.join(l:flags, '\ ')

  for l:item in s:shortcuts
    execute 'nnoremap <silent><buffer>'.l:item.key.' '.l:item.exec
  endfor

  let b:jshint_buffer = l:errors[0].bufnr
endfunction

function s:Ignore()
  let l:line = getloclist(0)[line('.') - 1]
  let l:number = l:line['nr']

  if !l:number
    return
  endif

  execute bufwinnr(l:line['bufnr']).'wincmd w'

  let l:error = '-'.l:line['type'].(('00'.l:number)[-3:])

  execute 'JSH '.join(b:jshint_flags).' '.l:error
endfunction

command! -nargs=* -complete=customlist,s:Complete -range=% -bang JSH call s:Lint(<line1>, <line2>, <bang>1, [<f-args>])

augroup JSH
  autocmd BufReadPost *
    \ if s:jshint_read && &filetype == 'javascript' |
      \ silent execute 'JSH' |
    \ endif

  autocmd BufWritePost *
    \ if s:jshint_save && &filetype == 'javascript' |
      \ silent execute 'JSH' |
    \ endif

  autocmd BufEnter *
    \ if s:jshint_close && exists('b:jshint_buffer') && bufwinnr(b:jshint_buffer) == -1 |
      \ quit |
    \ endif

  autocmd FileType qf call s:Map()
augroup END

