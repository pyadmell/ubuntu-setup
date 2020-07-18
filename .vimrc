call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
" Plug 'junegunn/fzf.vim'
" Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-git'
Plug 'w0rp/ale'
" Plug 'preservim/nerdcommenter'
" Plug 'jiangmiao/auto-pairs'
Plug 'xavierd/clang_complete'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'derekwyatt/vim-fswitch'
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-clang-format'
Plug 'vim-scripts/DoxygenToolkit.vim'
call plug#end()

" path to directory where library can be found
let g:clang_library_path='/usr/lib/llvm-6.0/lib'
" enable mouse
set mouse=a
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility
set nocompatible
" use indentation of previous line
set autoindent
" use smart indentation for C
set smartindent
" configure tab size and space instead of tabs
set tabstop=2    " tab width = 2 spaces"
set shiftwidth=2   " indent = 2 spaces"
set expandtab      " extend tab to spaces
" Wrap lines at 120 chars
set textwidth =120
" configure light line 
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
" Indent automatically depending on filetype
filetype indent on
" enable syntax and plugins for netrw
syntax enable
filetype plugin on
" Search down into subfolders (run vim from the root)
set path+=**
" Display all matching files when tab
set wildmenu
" Create tag file
command! MakeTags !ctags -R .
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" Always use bash syntax for sh filetype
let g:is_bash=1
" Search
set ignorecase smartcase
set grepprg=grep\ -IrsnH
" Case insensitive search
set ic
" Higlhight search
set hls
" Wrap text instead of being on one line
set lbr
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="Peyman Yadmellat <p.yadmellat@gmail.com>"

" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" recreate tags file with F5
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :make<CR>
" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" goto definition with F12
map <F12> <C-]>
" in diff mode we use the spell check keys for merging
if &diff
  ” diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  set spellfile=~/.vim/spellfile.add
  map <M-Down> ]s
  map <M-Up> [s
endif
