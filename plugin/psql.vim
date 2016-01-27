" :Less
" turn vim into a pager for psql aligned results 
fun! Less()
  autocmd BufEnter * let &titlestring = 'PSQL Pager'
  set title
  set nocompatible
  set nowrap
  set nowrapscan
  set scrollopt=hor
  set scrollbind
  set nonumber
  set incsearch
  set hlsearch
  set smartcase
  set nostartofline
  set scrolloff=5
  "execute 'above split'
  execute 'new'
  wincmd j
  execute 'silent! 1,1g/List of/d'
  execute 'silent! 1,1g/Table/+2d'
  execute 'silent! 1,2d'
  let line_length = max(map(getline(1, '$'), 'len(v:val)'))
  execute "silent! %s/$/\\=repeat(' '," . line_length . "- virtcol('$'))"
  wincmd k
  execute 'silent! norm! P'

  wincmd j
  silent! g/^(\d\+ row/d | wincmd k | execute "silent! norm! P" | wincmd j
  norm! gg^
  wincmd k
  execute "silent! %s/$/\\=repeat(' '," . line_length . "- virtcol('$'))"
  norm! gg^
  " resize upper window to two lines
  execute 'resize 2'

  wincmd j
  "execute 'norm! 2'
  " hide statusline in lower window
  set laststatus=0
  " hide contents of upper statusline. editor note: do not remove trailing spaces in next line!
  set statusline=\  
  " arrows do scrolling instead of moving
  nnoremap OC zL
  nnoremap OB 
  nnoremap OD zH
  nnoremap OA 
  nnoremap l zL
  nnoremap j 
  nnoremap h zH
  nnoremap k 
  nnoremap K 20
  nnoremap J 20
  nnoremap L zL
  nnoremap H zH
  nnoremap u 20
  nnoremap d 20
  nnoremap U 20
  nnoremap D 20
  nnoremap G Gkk
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  nnoremap <Space> <PageDown>
  " faster quit (I tend to forget about the upper panel)
  nmap q :qa!
  nmap Q :qa!
  set noma
  set fillchars=stl:-,stlnc:-
endfun
command! -nargs=0 Less call Less()
