syntax on
nmap j gj
nmap k gk
set incsearch
set ignorecase
set smartcase
set hlsearch
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent

let g:word_count="<unknown>"
function WordCount()
  return g:word_count
endfunction
function UpdateWordCount()
  let lnum = 1
  let n = 0
  while lnum <= line('$')
    let n = n + len(split(getline(lnum)))
    let lnum = lnum + 1
  endwhile
  let g:word_count = n
endfunction

func! JournalMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk 
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
  set display=lastline
  set laststatus=2
  set updatetime=1000
  augroup WordCounter
    au! CursorHold,CursorHoldI * call UpdateWordCount()
  augroup END
  highlight User1 ctermbg=DarkBlue guibg=DarkBlue ctermfg=LightBlue guifg=LightBlue
  set statusline=%1*			" Switch to User1 color highlight
  set statusline+=Write\ the\ other\ way.
  "set statusline+=%<%F			" file name, cut if needed at start
  "set statusline+=%M			" modified flag
  "set statusline+=%y			" file type
  set statusline+=%=			" separator from left to right justified
  set statusline+=\ %{WordCount()}\ words\ -- 
  set statusline+=\ %P
endfu 
com! WP call JournalMode()

