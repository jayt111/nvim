" lp_solve syntax highlighting

if exists("b:current_syntax")
  finish
endif

" -------------------------------------------------------------------------
" Keywords
syntax keyword lpKeyword min max int bin

" -------------------------------------------------------------------------
" TODO-like tokens (for inside comments)
syntax keyword lpTodo TODO FIXME NOTE contained

" -------------------------------------------------------------------------
" Comments
" Must come BEFORE operator rule so / and * aren't stolen
" // single-line comment
syntax match lpComment "\/\/.*" contains=lpTodo

" /* ... */ multi-line comment
syntax region lpComment start="/\*" end="\*/" contains=lpTodo keepend

" -------------------------------------------------------------------------
" Constraint operators
syntax keyword lpConstraint eq ge le
syntax match lpConstraint ">=\|<=\|="

" -------------------------------------------------------------------------
" Numbers
syntax match lpNumber "\v\d+(\.\d+)?"

" -------------------------------------------------------------------------
" Variables
syntax match lpVariable "\<[A-Za-z_][A-Za-z0-9_]*\>"

" -------------------------------------------------------------------------
" Math operators (exclude / and * when they're part of comments)
syntax match lpOperator "[+\-:^]" containedin=ALLBUT,lpComment
syntax match lpOperator "[*/]" containedin=ALLBUT,lpComment

syntax match lpComment "\/\/.*" contains=lpTodo
" -------------------------------------------------------------------------
" Highlight links
highlight def link lpKeyword Keyword
highlight def link lpConstraint Operator
highlight def link lpOperator Operator
highlight def link lpNumber Number
highlight def link lpVariable Identifier
highlight def link lpComment Comment
highlight def link lpTodo Todo

let b:current_syntax = 'lp_solve'

