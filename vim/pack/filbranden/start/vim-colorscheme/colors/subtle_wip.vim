" This is still *WORK IN PROGRESS*
" Not recommended for actual use just yet...

" Helpful colorguide:
" http://en.wikipedia.org/w/index.php?title=File:Xterm_256color_chart.svg
"
" In PNG format:
" http://upload.wikimedia.org/wikipedia/commons/9/95/Xterm_color_chart.png
"
" Source code for the SVG available here:
" https://gist.github.com/2868981
"
" TODO: Rebuild this using
" https://github.com/lifepillar/vim-colortemplate

" here are some lines that can be used to test settings for SpecialKey and NonText (used when nowrap is in effect, let's hope this line is long enough):
        " these are 8 spaces
	" this is a tab
        " trailing spaces on this line        

hi clear

if exists("g:syntax_on")
  syntax reset
endif

if &t_Co ==# 256 || has("gui_running")
  if &bg ==# "dark"
    " use pure white on pure black
    hi Normal ctermfg=231 ctermbg=16 guifg=#ffffff guibg=#000000
    "hi Normal ctermfg=231 ctermbg=0 guifg=#ffffff guibg=#000000
    set background=dark

    " comments are light gray
    hi Comment ctermfg=249 guifg=#b2b2b2

    " highlight TODO items in bold bright yellow on dark gray
    hi Todo ctermfg=226 ctermbg=236 cterm=bold guifg=#ffff00 guibg=#303030 gui=bold

    " very light yellow for Statements (reserved words)
    "hi Statement ctermfg=229
    hi Statement ctermfg=230 cterm=NONE guifg=#ffffd7 gui=NONE

    " make PreProc (from/import in Python, #include in C, etc.) same as keywords
    hi clear PreProc
    hi link PreProc Statement

    " very light blue for Identifiers (function, class names, etc.)
    " slightly worse blue: hi Identifier ctermfg=195 cterm=NONE
    "hi Identifier ctermfg=159 cterm=NONE guifg=#afffff gui=NONE
    " No, I changed my mind! Don't highlight it at all!
    hi clear Identifier

    " very light green for structure (Python exceptions, what else?)
    "hi Type ctermfg=158 guifg=#afffd7
    " No, I changed my mind! Don't highlight it at all!
    hi clear Type

    " don't highlight constants (strings, numbers) for now
    hi clear Constant

    " highlight trailing spaces and tabs with a very dark gray
    " clearly visible but not annoying! :-)
    " note: this uses the 'listchars' setting from google.vim
    " note: nvim uses 'Whitespace', while vim uses 'SpecialKey',
    " link them together.
    hi Whitespace ctermfg=249 ctermbg=234 guifg=#b2b2b2 guibg=#1c1c1c
    hi clear SpecialKey
    hi link SpecialKey Whitespace

    " MatchParen, gray background, not too strong
    " also hlsearch, same.
    hi clear MatchParen
    hi MatchParen ctermbg=238 guibg=#444444
    hi clear Search
    hi Search ctermbg=238 guibg=#444444

    " and hardcode the blue used for non-text (~ ~ ~)
    hi NonText ctermfg=68 guifg=#5f87d7

    " completion menu: light blue background,
    " bold black on green for selection
    hi Pmenu ctermfg=232 ctermbg=63 guifg=#080808 guibg=#5f5fff
    hi PmenuSel ctermfg=16 ctermbg=28 cterm=bold guifg=#000000 guibg=#008700 gui=bold

  else
    " use pure black on pure white
    hi Normal ctermfg=16 ctermbg=230 guifg=#000000 guibg=#ffffdf
    set background=light

    " comments are dark gray
    hi Comment ctermfg=239 guifg=#4e4e4e

    " highlight TODO items in black on bright yellow
    hi Todo ctermfg=238 ctermbg=220 cterm=bold guifg=#444444 guibg=#ffdf00 gui=bold

    " dark brown for Statements (reserved words)
    hi Statement ctermfg=58 cterm=NONE guifg=#5f5f00 gui=NONE

    " make PreProc (from/import in Python, #include in C, etc.) same as keywords
    hi clear PreProc
    hi link PreProc Statement

    " very dark blue for Identifiers (function, class names, etc.)
    "hi Identifier ctermfg=17 cterm=NONE guifg=#00005f gui=NONE
    " No, I changed my mind! Don't highlight it at all!
    hi clear Identifier

    " very dark green for structure (Python exceptions, what else?)
    "hi Type ctermfg=22 guifg=#005f00
    " No, I changed my mind! Don't highlight it at all!
    hi clear Type

    " don't highlight constants (strings, numbers) for now
    hi clear Constant

    " highlight trailing spaces and tabs with a slightly darker background
    " clearly visible but not annoying! :-)
    " note: this uses the 'listchars' setting from google.vim
    hi Whitespace ctermfg=239 ctermbg=229 guifg=#4e4e4e guibg=#ffffaf
    hi clear SpecialKey
    hi link SpecialKey Whitespace

    " and hardcode the blue used for non-text (~ ~ ~)
    hi NonText ctermfg=68 guifg=#5f87d7

    " use blue blackground on the completion menu
    " other than that everything else looks ok...
    hi Pmenu ctermbg=153 guibg=#afd7ff

  endif

  hi clear Special

else
  " clear about everything... if we don't have enough colors then don't bother
  " with syntax highlighting...
  if &bg ==# "dark"
    " set a sane-ish background (Ubuntu, I'm looking at you!)
    hi Normal ctermfg=15 ctermbg=0 cterm=NONE term=NONE

    " keep comments grey
    hi Comment ctermfg=7 ctermbg=0 cterm=NONE term=NONE

    " highlight tabs, trailing spaces and nowrap markers
    hi Whitespace ctermfg=4 ctermbg=8 cterm=NONE term=NONE
    hi clear SpecialKey
    hi link SpecialKey Whitespace
    hi NonText ctermfg=4 ctermbg=0 cterm=NONE term=NONE

  else
    " best I managed to do with 8 colors...
    hi Normal ctermfg=0 ctermbg=7 cterm=NONE term=NONE

    " I don't really have a good color for comments
    hi clear Comment

    " keep tabs, trailing spaces and nowrap markers blue
    hi Whitespace ctermfg=4 ctermbg=7 cterm=NONE term=NONE
    hi clear SpecialKey
    hi link SpecialKey Whitespace
    hi NonText ctermfg=4 ctermbg=7 cterm=NONE term=NONE

  endif

  hi clear Todo
  hi clear Statement
  hi clear PreProc
  hi clear Identifier
  hi clear Type
  hi clear Constant
  hi clear Special

endif

let colors_name = "subtle_wip"

