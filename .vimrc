""general Vim stuff
set number                              "turn on numbering
set hlsearch                            "highlight search
syntax on                               "Syntax coloring
syntax enable
filetype plugin on
filetype indent on
set sft             "show full tags when autocomplete
set nowrap				                "no text wrapping
set background=dark
colorscheme solarized

"splitting
set splitright
set splitbelow

" Indentation
set smartindent
set autoindent
set tabstop=4       
set softtabstop=4   " replace tab with 4 spaces
set shiftwidth=4
set expandtab       " expand tabs to spaces

" GUI Opts
"set colorcolumn=80

set guioptions+=LlRrbmT
set guioptions-=LlRrbmT

  ""Next lines for whitepsace highlighting
  highlight ExtraWhitespace ctermbg=red guibg=red "create a highlight group
  match ExtraWhitespace /\s\+$/                   "Match trailing whitespace
  "match                                          "Turn off match highlighting


" Keyboard mappings
let mapleader = ","                     "Set leader to comma
nnoremap <leader><tab> :tabn<CR>
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <leader>n :tabnew<CR>
nnoremap <c-n>     :tabnew<CR>
nnoremap <leader>vs :vs<CR>
nnoremap <leader>s  :split<CR>
nnoremap <leader><space> @q<CR>
nnoremap <leader>p  :exec '!python' shellescape(@%, 1)<cr>
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j 
nnoremap <leader>k <c-w>k 
nnoremap <leader>l <c-w>l 
nnoremap <leader>w :confirm q<cr>
nnoremap <space> 10j

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

" Puts in the current git status
"    if count(g:pathogen_disabled, 'Fugitive') < 1   
"        set statusline+=%{fugitive#statusline()}
"    endif

" Puts in syntastic warnings
"    if count(g:pathogen_disabled, 'Syntastic') < 1  
"        set statusline+=%#warningmsg#
"        set statusline+=%{SyntasticStatuslineFlag()}
"        set statusline+=%*
"    endif

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

"set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%4*\ %<%F%*            "full path
"set statusline +=%2*%m%*                "modified flag
"set statusline +=%1*%=%5l%*             "current line
"set statusline +=%2*/%L%*               "total lines
"set statusline +=%1*%4v\ %*             "virtual column number
set laststatus=2

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
