if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetJsIndent(v:lnum)
setlocal indentkeys=
setlocal cindent
setlocal autoindent

function! s:SearchForPair(lnum, beg, end)
  let curpos = getpos(".")

  call cursor(a:lnum, 0)

  let mnum = searchpair(a:beg, '', a:end, 'bW',
      \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? s:syn_comment' )

  call cursor(curpos)

  return mnum
endfunction

" Comments \\\

let s:js_mid_line_comment = '\s*\(\/\*.*\*\/\)*\s*'
let s:js_end_line_comment = s:js_mid_line_comment . '\s*\(//.*\)*'
let s:js_line_comment = s:js_end_line_comment
let s:syn_comment = '\(Comment\|String\|Regexp\)'

function! s:IsInComment(lnum, cnum)
  return synIDattr(synID(a:lnum, a:cnum, 1), 'name') =~? s:syn_comment
endfunction

function! s:IsComment(lnum)
  let line = getline(a:lnum)

  return s:IsInComment(a:lnum, 1) && s:IsInComment(a:lnum, strlen(line)) "Doesn't absolutely work.  Only Probably!
endfunction

function! s:GetNonCommentLine(lnum)
  let lnum = prevnonblank(a:lnum)

  while lnum > 0
    if s:IsComment(lnum)
      let lnum = prevnonblank(lnum - 1)
    else
      return lnum
    endif
  endwhile

  return lnum
endfunction

" ///

" Objects \\\

let s:object_beg = '{[^}]*' . s:js_end_line_comment . '$'
let s:object_end = '^' . s:js_mid_line_comment . '}[;,]\='

function! s:IsObjectBeg(line)
  return a:line =~ s:object_beg
endfunction

function! s:IsObjectEnd(line)
  return a:line =~ s:object_end
endfunction 

function! s:GetObjectBeg(lnum)
  return s:SearchForPair(a:lnum, '{', '}')
endfunction

" ///

" Arrays \\\

let s:array_beg = '\[[^\]]*' . s:js_end_line_comment . '$'
let s:array_end = '^' . s:js_mid_line_comment . '[^\[]*\][;,]*' . s:js_end_line_comment . '$'

function! s:IsArrayBeg(line)
  return a:line =~ s:array_beg
endfunction

function! s:IsArrayEnd(line)
  return a:line =~ s:array_end
endfunction

function! s:GetArrayBeg(lnum)
  return s:SearchForPair(a:lnum, '\[', '\]')
endfunction

" ///

" MultiLine \\\

let s:paren_beg = '([^)]*' . s:js_end_line_comment . '$'
let s:paren_end = '^' . s:js_mid_line_comment . '[^(]*)[;,]*'

function! s:IsParenBeg(line)
  return a:line =~ s:paren_beg
endfunction

function! s:IsParenEnd(line)
  return a:line =~ s:paren_end
endfunction

function! s:GetParenBeg(lnum)
  return s:SearchForPair(a:lnum, '(', ')')
endfunction

" ///

" Continuation \\\

let s:continuation = '\(+\|\\\)\{1}' . s:js_line_comment . '$'

function! s:IsContinuationLine(line)
  return a:line =~ s:continuation
endfunction

function! s:GetContinuationBegin(lnum)
  let cur = a:lnum

  while s:IsContinuationLine(getline(cur))
    let cur -= 1
  endwhile

  return cur + 1
endfunction

" ///

" Switch \\\

let s:switch_beg_next_line = 'switch\s*(.*)\s*' . s:js_mid_line_comment . s:js_end_line_comment . '$'
let s:switch_beg_same_line = 'switch\s*(.*)\s*' . s:js_mid_line_comment . '{\s*' . s:js_line_comment . '$'
let s:switch_mid = '^.*\(case.*\|default\)\s*:\s*' 

function! s:IsSwitchBeginNextLine(line)
  return a:line =~ s:switch_beg_next_line
endfunction

function! s:IsSwitchBeginSameLine(line)
  return a:line =~ s:switch_beg_same_line
endfunction

function! s:IsSwitchMid(line)
  return a:line =~ s:switch_mid
endfunction

" ///

" Control \\\

let s:cntrl_beg_keys = '\(\(\(if\|for\|with\|while\)\s*(.*)\)\|\(try\|do\)\)\s*'
let s:cntrl_mid_keys = '\(\(\(else\s*if\|catch\)\s*(.*)\)\|\(finally\|else\)\)\s*'

let s:cntrl_beg = s:cntrl_beg_keys . s:js_end_line_comment . '$'
let s:cntrl_mid = s:cntrl_mid_keys . s:js_end_line_comment . '$'

let s:cntrl_end = '\(while\s*(.*)\)\s*;\=\s*' . s:js_end_line_comment . '$'

function! s:IsControlBeg(line)
  return a:line =~ s:cntrl_beg
endfunction

function! s:IsControlMid(line)
  return a:line =~ s:cntrl_mid
endfunction

function! s:IsControlMidStrict(line)
  return a:line =~ s:cntrl_mid
endfunction

function! s:IsControlEnd(line)
  return a:line =~ s:cntrl_end
endfunction

" Indent \\\

function! GetJsIndent(lnum)
  let pnum = s:GetNonCommentLine(a:lnum-1)

  if pnum == 0
    call s:Log("No, noncomment lines prior to the current line.")

    return 0
  endif

  let ppnum = s:GetNonCommentLine(pnum-1)

  call s:Log("Line: " . a:lnum)
  call s:Log("PLine: " . pnum)
  call s:Log("PPLine: " . ppnum)

  let line = getline(a:lnum)
  let pline = getline(pnum)
  let ppline = getline(ppnum)
  let ind = indent(pnum)

  if s:IsObjectEnd(line) && !s:IsComment(a:lnum)
    call s:Log("Line matched object end")

    let obeg = s:GetObjectBeg(a:lnum)
    let oind = indent(obeg)
    let oline = getline(obeg)

    call s:Log("The object beg was found at: " . obeg)

    return oind
  endif

  if s:IsObjectBeg(pline)
    call s:Log("Pline matched object beg")

    return ind + &sw
  endif

  if s:IsArrayEnd(line) && !s:IsComment(a:lnum)
    call s:Log("Line matched array end")

    let abeg = s:GetArrayBeg(a:lnum)
    let aind = indent(abeg)

    call s:Log("The array beg was found at: " . abeg)

    return aind
  endif

  if s:IsArrayBeg(pline)
    call s:Log("Pline matched array beg")

    return ind + &sw
  endif

  if s:IsParenEnd(line) && !s:IsComment(a:lnum)
    call s:Log("Line matched paren end")

    let abeg = s:GetParenBeg(a:lnum)
    let aind = indent(abeg)

    call s:Log("The paren beg was found at: " . abeg)

    return aind
  endif

  if s:IsParenBeg(pline)
    call s:Log("Pline matched paren beg")

    return ind + &sw
  endif

  if s:IsContinuationLine(pline)
    call s:Log('Pline is a continuation line.')

    let cbeg = s:GetContinuationBegin(pnum)
    let cind = indent(cbeg)

    call s:Log('The continuation block begin found at: ' . cbeg)

    return cind + &sw
  endif

  if s:IsContinuationLine(ppline)
    call s:Log('PPline was a continuation line but pline wasnt.')

    return ind - &sw
  endif

  if s:IsSwitchMid(pline) 
    call s:Log("PLine matched switch cntrl mid")

    if s:IsSwitchMid(line) || s:IsObjectEnd(line)
      call s:Log("Line matched a cntrl mid")

      return ind
    else
      call s:Log("Line didnt match a cntrl mid")

      return ind + &sw
    endif
  endif

  if s:IsSwitchMid(line)
    call s:Log("Line matched switch cntrl mid")

    return ind - &sw
  endif

  if s:IsControlBeg(pline)
    call s:Log("Pline matched control beginning")

    if s:IsControlMid(line)
      call s:Log("Line matched a control mid")

      return ind
    elseif line =~ '^\s*{\s*$'
      call s:Log("Line matched an object beg")

      return ind
    else
      return ind + &sw
    endif
  endif

  if s:IsControlMid(pline)
    call s:Log("Pline matched a control mid")

    if s:IsControlMid(line)
      call s:Log("Line matched a control mid")

      return ind
    elseif s:IsObjectBeg(line)
      call s:Log("Line matched an object beg")

      return ind
    else
      call s:Log("Line didn't match a control mid or object beg."

      return ind + &sw
    endif
  endif

  if s:IsControlMid(line)
    call s:Log("Line matched a control mid.")

    if s:IsControlEnd(pline) || s:IsObjectEnd(pline)
      call s:Log("PLine matched control end")

      return ind
    else
      call s:Log("Pline didn't match object end")

      return ind - &sw
    endif
  endif

  if ( s:IsControlBeg(ppline) || s:IsControlMid(ppline) ) &&
      \ !s:IsObjectBeg(pline) && !s:IsObjectEnd(pline)
    call s:Log("PPLine matched single line control beg or mid")

    return ind - &sw
  endif

  return ind
endfunction

" ///

