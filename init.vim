"
" macOS
"   brew install neovim
"   brew install python3
"   brew cask install font-hack-nerd-font
"   brew install ctags
"   brew install the_silver_searcher
"
"   pip3 install neovim
"
" First run:
"   :PlugInstall
"
filetype plugin indent on
let mapleader = ','

" plugins ---------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'gertjanreynaert/cobalt2-vim-theme'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rking/ag.vim'
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'szw/vim-tags'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" airline
let g:airline_powerline_fonts = 1
let g:airline_enable_syntastic = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s '
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#fnamemod = ':t'

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" rainbow_parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

" vim-markdown
let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
let g:vim_markdown_folding_disabled=1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_ruby_checkers = ['mri', 'rubylint', 'rubocop']
let g:syntastic_puppet_checkers = ['puppet', 'puppetlint']
nmap <leader>ts :SyntasticToggleMode \| w<CR> " [,ts] Toggle Syntastic.

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
nmap <leader>ti <Plug>IndentGuidesToggle " [,ti] Toggle indent.

" tagbar
nmap <leader>tt :TagbarToggle<CR>

" deoplete
let g:deoplete#enable_at_startup = 1

" ag|the_silver_searcher
if executable("ag")
  " Note we extract the column as well as the file and line number
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m

  " Have the silver searcher ignore all the same things as wilgignore
  let b:ag_command = 'ag %s -i --nocolor --nogroup'

  for i in split(&wildignore, ",")
    let i = substitute(i, '\*/\(.*\)/\*', '\1', 'g')
    let b:ag_command = b:ag_command . ' --ignore "' . substitute(i, '\*/\(.*\)/\*', '\1', 'g') . '"'
  endfor

  let b:ag_command = b:ag_command . ' --hidden -g ""'
  let g:ctrlp_user_command = b:ag_command
endif


" colors
set t_Co=256
set background=dark
syntax on

" Settings --------------------------------------------------------------------
set number
set relativenumber
set autoindent
set backspace=indent,eol,start
set cursorline
set encoding=utf-8 nobomb
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set hidden
set history=1000
set hlsearch
set ignorecase
set smartcase
set incsearch
set laststatus=2
set magic
set mouse=a
set noerrorbells
set nojoinspaces
set noshowmode
set nowrap
set ofu=syntaxcomplete#Complete
set regexpengine=1
set ruler
set scrolloff=3
set sidescrolloff=3
set splitbelow
set splitright
set title
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/log/*,*/tmp/*,*/build/*,*/doc/*,*/dist/*
set wildmenu
set wildmode=list:longest
set winminheight=0
set wrapscan
set lazyredraw
set list
set listchars=tab:▸\
set listchars+=trail:·
set listchars+=eol:¬
set listchars+=nbsp:_
set fileformats=unix,dos,mac


" Functions -------------------------------------------------------------------
function! StripTrailingWhitespaces()
  let searchHistory = @/
  let cursorLine = line(".")
  let cursorColumn = col(".")

  %s/\s\+$//e

  let @/ = searchHistory
  call cursor(cursorLine, cursorColumn)
endfunction

augroup strip_trailing_whitespaces

  " List of file types for which the trailing whitespaces
  " should not be removed:

  let excludedFileTypes = []

  " Only strip the trailing whitespaces if
  " the file type is not in the excluded list.

  autocmd!
  autocmd BufWritePre * if index(excludedFileTypes, &ft) < 0 | :call StripTrailingWhitespaces()

augroup END

" Helpers ---------------------------------------------------------------------
nmap <leader>v :vsp $MYVIMRC<CR> " [,v ] Make the opening of the `.vimrc` file easier.
nmap <leader>W :w !sudo tee %<CR> " [,W ] Sudo write.
nmap <leader>cs <Esc>:noh<CR> " [,cs] Clear search.
nmap <leader>* :%s/\<<C-r><C-w>\>//<Left> " [,* ] Search and replace the word under the cursor.
nmap <leader>ss :call StripTrailingWhitespaces()<CR>

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
