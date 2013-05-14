source ~/.vim/functions.vim

call pathogen#infect()

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
let g:Powerline_symbols = 'fancy'

set nofoldenable    " disable folding

command -nargs=+ MapToggle call MapToggle(<f-args>)

set history=100         " keep 100 lines of history
set ruler               " show the cursor position
syntax on               " syntax highlighting
" set background=dark
" colorscheme solarized
" colorscheme darkblue
colorscheme ron

let g:syntastic_auto_jump=1
let g:syntastic_mode_map = { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }
let g:syntastic_perl_lib_path = './lib'
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_perl_checkers=['perl','perlcritic']
let g:syntastic_perl_perlcritic_args="--theme corvisa"

set hlsearch            " highlight the last searched term
filetype plugin on      " use the file type plugins
au BufNewFile,BufRead *.psgi set filetype=perl

set smartindent
set tabstop=4
set shiftwidth=4
set nu
set viminfo='10,\"100,:20,%,n~/.viminfo

"set iskeyword=@,58
nmap _M :!xdg-open https://metacpan.org/module/<cword><CR>
nmap _H :!perlfind <cword><CR>

" move lines
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" create pastie
nnoremap <C-p> :!curl -s -F data=@% http://pastie.it.corp/ \| xclip -selection clipboard; xclip -selection clipboard -o<CR>
vnoremap <C-p> <esc>:'<,'>:w !curl -s -F data=@- http://pastie.it.corp/ \| xclip -selection clipboard; xclip -selection clipboard -o<CR>

MapToggle <F2> paste
map <F3> :let t = winsaveview()<CR>:%!perltidy<CR>:%!podtidy<CR>:w<CR>:call winrestview(t)<CR>
vnoremap <F3> <esc>:'<,'>!perltidy<CR>:w<CR>
" map <F4> :w<CR>:!perl -Ilib -c %;podchecker %;perlcritic --theme corvisa %<CR>
map <F4> :SyntasticCheck<CR>
map <F5> :w<CR>:!script -c 'HARNESS_ACTIVE=1 prove -lvmfo %' /tmp/last-prove.txt<CR>:!less -R -F +G /tmp/last-prove.txt<CR>
map <F6> :!less -R /tmp/last-prove.txt<CR>
MapToggle <F7> hlsearch
MapToggle <F8> wrap
map <F9> :TagbarOpenAutoClose<CR>

" git blame
vmap _B :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" Support for scroll wheel
map <M-Esc>[62~ <MouseDown>
map! <M-Esc>[62~ <MouseDown>
map <M-Esc>[63~ <MouseUp>
map! <M-Esc>[63~ <MouseUp>
map <M-Esc>[64~ <S-MouseDown>
map! <M-Esc>[64~ <S-MouseDown>
map <M-Esc>[65~ <S-MouseUp>
map! <M-Esc>[65~ <S-MouseUp>

set mouse=a


" Show trailing whitespace

highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

