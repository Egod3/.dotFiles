autocmd Filetype c setlocal tabstop=4
autocmd Filetype h setlocal tabstop=4
autocmd Filetype cpp setlocal tabstop=4
autocmd Filetype cs setlocal tabstop=4

set tabstop=2
set expandtab
set shiftwidth=0
set shiftround

" awesome colorscheme?
" colorscheme solarized

syntax enable " enable syntax processsing
set number " show line numbers
set showcmd " show the command in bottom bar

" Automatically remove trailing white space from lines on file write
autocmd BufWritePre * :%s/\s\+$//e

" Highlight white space at the end of a line or in front of a tab
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

source ~/.config/nvim/cscope_maps.vim
