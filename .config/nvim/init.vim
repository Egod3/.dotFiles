" Function to generaate ctags
function! UpdateCscope ()
  echo "Running function UpdateCscope()..."

"  Add the below 4-5 lines and use on a src directory.
  find | grep "\.c$\|\.h$" > cscope.files
  sort cscope.files > cscope.files.sorted
  mv cscope.files.sorted cscope.files
  cscope -b
"  ctags -L cscope.files
endfunction

function! Test ()
  echo "test func in vim"
endfunction

nmap <silent>  <C-B>  :call UpdateCscope()<CR>

autocmd Filetype c setlocal tabstop=4
autocmd Filetype h setlocal tabstop=4
autocmd Filetype cpp setlocal tabstop=4
autocmd Filetype cs setlocal tabstop=4

" Shortcuts to make fugitive.vim (git in vim) easier to use
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gc :Git commit -v<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gb :Gbranch<CR>
nnoremap <space>gf :Gfetch<CR>
nnoremap <space>gr :Grebase<CR>
nnoremap <space>gl :Git log<CR>

set tabstop=2
set expandtab
set shiftwidth=0
set shiftround

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax enable " enable syntax processsing
set number " show line numbers
set showcmd " show the command in bottom bar
filetype plugin on

" Automatically remove trailing white space from lines on file write
autocmd BufWritePre * :%s/\s\+$//e

" Turn on mouse mode
"set mouse=a
"map <ScrollWheelUp> <C-Y>
"map <ScrollWheelDown> <C-E>

" Highlight white space at the end of a line or in front of a tab
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
source ~/.config/nvim/cscope_maps.vim

" Info to add Nerdtree to vim
"call pathogen#infect()
"syntax on
"filetype plugin indent on
" Ctlr+<ENTER> to auto open/close nerd tree
" Ctlr+c to open/close nerd tree
noremap <C-n> :NERDTreeToggle<CR>

" init vim-plug
" Install new plugins in between the two 'call' calls below.
call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/TagHighlight'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

call plug#end()

"syntax on
"colorscheme onedark
colorscheme gruvbox
set background=dark " use dark mode

