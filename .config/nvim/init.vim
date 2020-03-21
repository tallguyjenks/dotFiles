"=================================="
"       Begin Plugins Section 	   "
"=================================="
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
Plug 'PotatoesMaster/i3-vim-syntax' 		" i3 Config Syntax highlighting
Plug 'kovetskiy/sxhkd-vim'			" sxhkd Config file syntax highlighting
Plug 'scrooloose/nerdtree' 			" NerdTree File Tree
Plug 'Xuyuanp/nerdtree-git-plugin'		" NerdTree Show Git Status Icons in Nerd Tree
Plug 'ryanoasis/vim-devicons'			" NerdTree Icons for filetypes
Plug 'airblade/vim-gitgutter'			" Git code line change icons
Plug 'vim-scripts/restore_view.vim'		" Remember code folds and cursor position
Plug 'junegunn/goyo.vim' 			" Focus Mode
Plug 'bling/vim-airline' 			" Airline Status bar Vim
Plug 'vifm/vifm.vim'				" Allows use of vifm as a file picker
Plug 'godlygeek/tabular' 			" Markdown Tables
Plug 'mhinz/vim-startify' 			" Start screen for vim
Plug 'tpope/vim-commentary' 			" T-Pope / Comment out code in a variety of langs
Plug 'tpope/vim-surround' 			" T-Pope / Change surrounding tags, characters, quotes, etc.
Plug 'tpope/vim-markdown' 			" T-Pope / For markdown fenced langs syntax highlighting
Plug 'vim-pandoc/vim-rmarkdown' 		" RMarkdown Docs in Vim
Plug 'vim-pandoc/vim-pandoc' 			" RMarkdown Docs in Vim
Plug 'vim-pandoc/vim-pandoc-syntax' 		" RMarkdown Docs in Vim
Plug 'ying17zi/vim-live-latex-preview' 		" LaTeX Compiling Live
"Plug 'neoclide/coc.nvim',{'branch': 'release'} " Code Completion
"Plug 'rust-lang/rust.vim'			" Full Rust language support
"Plug 'vimwiki/vimwiki' 			" Dont Really Use Vimwiki much anymore
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
call plug#end()

"=================================="
"             LEADER	   	   "
"=================================="

" ~~~~~ Set Leader Character
	let mapleader =","

"=================================="
"          Code Folding	   	   "
"=================================="

" ~~~~~ Enable Tabbed Code Folding
	set foldmethod=indent "expr
	set foldlevel=99
" ~~~~~ Enable folding with the spacebar
	nnoremap <space> za

"=================================="
"          Miscellaneous	   "
"=================================="

" ~~~~~ Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>
" ~~~~~ Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>
" ~~~~~ Black hole registry https://bit.ly/2WARts6
	nnoremap c "_c

	set autoindent 				" New lines inherit indentation of preceding lines
	set bg=light 				" Use colors that suit a dark background
	set go=a				" Hide GuiOptions
	set mouse=a 				" Enable mouse usage
	set nohlsearch 				" disable search highlighting
	set clipboard=unnamed,unnamedplus 	" Allow copied vim text to also be added to clipboard
	set nospell 				" When on spell checking will be done
	set nocompatible 			" Dont worry about VI compatability, do yo thang
	set encoding=utf-8 			" Use an encoding that supports unicode.
	set number relativenumber 		" line numbers and relative line numbers
	filetype plugin on 			" File type detection
	syntax on 				" Turn on syntax highlighting

" ~~~~~ This maps CTRL-C to T-popes commentary for commenting out any code
	map <C-c> gcc
" ~~~~~ Mark the 81st and greater columns with a marker that im exceeding
	highlight ColorColumn ctermbg=magenta
	call matchadd('ColorColumn','\%81v',100)
" ~~~~~ Highlight white space and tab characters
	exec "set listchars=tab:\u00B7\u00B7,trail:\u2423,nbsp:~"
	set list
" ~~~~~ Turn off arrow keys in ALL modes
	noremap <up> <nop>
	noremap <down> <nop>
	noremap <left> <nop>
	noremap <right> <nop>
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>
	nnoremap <up> <nop>
	nnoremap <down> <nop>
	nnoremap <left> <nop>
	nnoremap <right> <nop>
	vnoremap <up> <nop>
	vnoremap <down> <nop>
	vnoremap <left> <nop>
	vnoremap <right> <nop>
" ~~~~~ Turns off highlighting on the bits of code that are changed,
" ~~~~~ so the line that is changed is highlighted but the actual text
" ~~~~~ that has changed stands out on the line and is readable.
	if &diff
	    highlight! link DiffText MatchParen
	endif
" ~~~~~ Enable autocompletion:
	set wildmode=longest,list,full
" ~~~~~ Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" ~~~~~ Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" ~~~~~ Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
" ~~~~~ When shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" ~~~~~ Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" ~~~~~ Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" ~~~~~ Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" ~~~~~ Navigating with guides
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l

"=================================="
"       Nerd Tree Section 	   "
"=================================="

" ~~~~~ Open Nerdtree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let NERDTreeShowHidden=1 				" Shows hidden files
	let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp'] 	" Do not display some useless files in the tree:
" ~~~~~ Always open the tree when booting Vim, but don’t focus it:
	"autocmd VimEnter * NERDTree
	"autocmd VimEnter * wincmd p
	set guifont=nerd-fonts-source-code-pro	" Make it so the Devicons plugin displays correctly in nerdtree

"=================================="
"       Split Management	   "
"=================================="

" ~~~~~ Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright
" ~~~~~ Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
" ~~~~~ Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>

"=================================="
"       Document Compiling	   "
"=================================="

" ~~~~~ Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>
" ~~~~~ Turn on Autocompiler mode
	map <leader>a :!setsid autocomp % &<CR>
" ~~~~~ Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>
" ~~~~~ Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

"=================================="
"             VIM WIKI	   	   "
"=================================="

" ~~~~~ Ensure files are read as what I want in vimwiki:
	"let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	"let g:vimwiki_list = [{'path': '~/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]
	"autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	"autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	"autocmd BufRead,BufNewFile *.tex set filetype=tex

"=================================="
"          	GOYO	   	   "
"=================================="

" ~~~~~ Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
" ~~~~~ Enable Goyo by default for mutt writting
" ~~~~~ Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

"=================================="
"       	HTML		   "
"=================================="

	autocmd FileType html inoremap ,b <b></b><Space><++><Esc>FbT>i
	autocmd FileType html inoremap ,i <em></em><Space><++><Esc>FeT>i
	autocmd FileType html inoremap ,c <code></code><Space><++><Esc>FeT>i
	autocmd FileType html inoremap ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,p <p></p><Enter><br><Enter><++><Esc>02kf>a
	autocmd FileType html inoremap ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap ,li <Esc>o<li></li><Esc>F>a
	autocmd FileType html inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap ,im <img src="" alt="<++>"><++><esc>Fcf"a
	autocmd FileType html inoremap ,td <td></td><++><Esc>Fdcit
	autocmd FileType html inoremap ,tr <tr></tr><Enter><++><Esc>kf<i
	autocmd FileType html inoremap ,th <th></th><++><Esc>Fhcit
	autocmd FileType html inoremap ,tab <table><Enter></table><Esc>O
	autocmd FileType html inoremap &<space> &amp;<space>

"=================================="
"       	BIB		   "
"=================================="

 	autocmd FileType bib inoremap ,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
 	autocmd FileType bib inoremap ,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>ISBN<Space>=<Space>{<++>}<Enter>}<Enter><++><Esc>7kA,<Esc>i
 	autocmd FileType bib inoremap ,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i

"=================================="
"            Markdown		   "
"=================================="

	autocmd Filetype markdown,rmd,Rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>n ---<Enter><Enter>
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>sub ~~<++><Esc>F~i
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>sup ^^<++><Esc>F^i
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>i **<++><Esc>F*i
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>[ [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>4 ####<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>5 #####<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd,Rmd inoremap <leader>6 ######<Space><Enter><++><Esc>kA
	autocmd Filetype rmd,Rmd inoremap <leader>r ```{r}<CR>```<CR><++><CR><Esc>2kO
	autocmd Filetype rmd,Rmd inoremap <leader>pic ```{r }<CR>knitr::include_graphics("<++>")<CR>```<Esc>2k$i

"=================================="
"       	XML		   "
"=================================="

	autocmd FileType xml inoremap ,e <item><Enter><title><++></title><Enter><guid<space>isPermaLink="false"><++></guid><Enter><pubDate><Esc>:put<Space>=strftime('%a, %d %b %Y %H:%M:%S %z')<Enter>kJA</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>?<title><enter>cit
	autocmd FileType xml inoremap ,a <a href="<++>"><++></a><++><Esc>F"ci"
