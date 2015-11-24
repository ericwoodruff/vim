set nocompatible " vim not vi

" dvorak - NOTE disable this for BundleInstall
set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,V>,Z?

" BEGIN vundle
filetype off                  " required

"http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Plugin 'gmarik/vundle'

    Plugin 'vim-ruby/vim-ruby'
    Plugin 'Syntastic' "uber awesome syntax and errors highlighter
    Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
    Plugin 'tpope/vim-fugitive' "So awesome, it should be illegal 
    Plugin 'L9'
    Plugin 'jonathanfilip/vim-lucius'
    Plugin 'wesgibbs/vim-irblack'
    Plugin 'Lokaltog/vim-distinguished'
    Plugin '29decibel/codeschool-vim-theme'
    Plugin 'baverman/vim-babymate256'
    Plugin 'vim-scripts/rdark'
    "Plugin 'AutoComplPop'
    Plugin 'fatih/vim-go'

    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

" yank with "+yy (_+yy in dvorak)
set clipboard=unnamedplus

set tags=./tags,tags;$HOME

set omnifunc=syntaxcomplete#Complete
if has("autocmd")
        filetype plugin indent on
	autocmd FileType ruby set omnifunc=rubycomplete#Complete
	autocmd FileType ruby let g:rubycomplete_buffer_loading=1
	autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif
" http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"set dir=/tmp/.vimswap/	" put swap files in /tmp

" for find and tabf
set path=$PWD/**

set nowrap 		" don't wrap lines
set autoindent		" auto indent lines
"set smartindent
" set hlsearch		" highlight seach results

"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals
set modeline		" Read vim: modlines from file header and footer

runtime macros/matchit.vim

syntax enable		" syntax coloring
set t_Co=256
set bg=dark
"colorscheme ir_black
colorscheme lucius
"LuciusBlack
"colo babymate256

" highlight Pmenu ctermbg=238 gui=bold
" highlight PmenuSel ctermfg=white ctermbg=darkgrey guifg=white guibg=grey40

:highlight ExtraWhitespace ctermbg=red guibg=red
" The following alternative may be less obtrusive.
" :highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Try the following if your GUI uses a dark background.
" :highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitepace and spaces before a tab:
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

if has("mouse")
"        "set mouse=i
"        set mouse=nvi
        imap <MouseUp> <C-R><CR>
        imap <MouseDown> <C-R><CR>
end

au BufRead,BufNewFile *.rabl setf ruby
au BufRead,BufNewFile *.rb setf ruby
autocmd FileType ruby,eruby,yaml,haml,rabl set ai sw=2 sts=2 et
au BufNewFile,BufRead *.gradle set filetype=groovy

" Movement between split windows
"nnoremap <C-k> <C-w>k
"nnoremap <C-j> <C-w>j
"nnoremap <C-l> <C-w>l
"nnoremap <C-h> <C-w>h

" Movement between tabs OR buffers
" nnoremap L :call MyNext()<CR>
"nnoremap N :call MyNext()<CR>
" nnoremap H :call MyPrev()<CR>
"nnoremap D :call MyPrev()<CR>

" Switch to recent buffer
" nnoremap K :b#<CR>
"nnoremap T :b#<CR>

" Custom Function Definitions {{{2
" MyNext() and MyPrev(): Movement between tabs OR buffers {{{3
"function! MyNext()
"    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
"	" Tab support && tabs open
"	normal gt
"    else
"	" No tab support, or no tabs open
"	execute ":bnext"
"    endif
"endfunction
"function! MyPrev()
"    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
"	" Tab support && tabs open
"	normal gT
"    else
"	" No tab support, or no tabs open
"	execute ":bprev"
"    endif
"endfunction
" }}}3

"map <PageUp> <C-U><C-U>
"map <PageDown> <C-D><C-D>
"imap <PageUp> <C-O><C-U><C-O><C-U>
"imap <PageDown> <C-O><C-D><C-O><C-D>

"http://vim.wikia.com/wiki/Go_away_and_come_back
"http://jaredforsyth.com/blog/2010/apr/9/vim-crash-recovery/
"set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos
"function! MakeSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"  if (filewritable(b:sessiondir) != 2)
"    exe 'silent !mkdir -p ' b:sessiondir
"    redraw!
"  endif
"  let b:filename = b:sessiondir . '/session.vim'
"  exe "mksession! " . b:filename
"endfunction
"
"function! LoadSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"  let b:sessionfile = b:sessiondir . "/session.vim"
"  if (filereadable(b:sessionfile))
"    exe 'source ' b:sessionfile
"  else
"    echo "No session loaded."
"  endif
"endfunction
"au VimEnter * nested :call LoadSession()
"au VimLeavePre * :call MakeSession()
"au BufAdd,BufNewFile * nested tab sball


set nobackup
set noswapfile

" http://blog.sanctum.geek.nz/vim-filename-completion/
set wildmenu
set wildmode=longest,list,full

hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
