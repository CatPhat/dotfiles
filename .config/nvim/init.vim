" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃                             * Neovim Config *                              ┃
" ┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┩
" │                      Maintained by: github.com/Catphat                     │
" │                        Inspired By: gihub.com/beanaroo                     │
" └────────────────────────────────────────────────────────────────────────────┘

" ╭────────────────────────────────────────────────────────────────────────────╮
" │                                  Plugins                                   │
" ╰────────────────────────────────────────────────────────────────────────────╯

" Fix ctrl+h
if has('nvim')
     nmap <BS> <C-W>h
endif


" ╭────────────────────────────────────────────────────────────────────────────╮
" │                             Filetype Config                                │
" ╰────────────────────────────────────────────────────────────────────────────╯
" file type recognition
filetype on
filetype plugin on
filetype indent on


" ═══════════════════════════╡ junegunn/vim-plug ╞══════════════════════════════

call plug#begin('~/.config/nvim/plugged')

" ══════════ User Interface ════════════

" Base16 colorscheme
Plug 'chriskempson/base16-vim'
" Enhanced Status & Tab lines
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Project panel
Plug 'scrooloose/nerdtree'
" git flags for project panel
Plug 'Xuyuanp/nerdtree-git-plugin'
" Filetype icons
Plug 'ryanoasis/vim-devicons'
" Neoterm
"Plug 'kassio/neoterm'
" Fuzzy file, buffer, mru, tag, etc finder
" ctrlp.vim
" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
" Tag browser
" https://github.com/universal-ctags/ctags
Plug 'universal-ctags/ctags'

" ════════════ Navigation ══════════════

" Quick jump
Plug 'easymotion/vim-easymotion'
" interactive regex search
Plug 'haya14busa/incsearch.vim'
" IncSearch fix for easymotion
Plug 'haya14busa/incsearch-easymotion.vim'
" Buffer navigation
Plug 'jeetsukumaran/vim-buffergator'
" Vim-tmux-navigation
Plug 'christoomey/vim-tmux-navigator'

" ═══════ Filetype extensions ══════════

" Advanced Pandoc markdown
Plug 'vim-pandoc/vim-pandoc' | Plug 'vim-pandoc/vim-pandoc-syntax'
" XML Tools
Plug 'othree/xml.vim'
" CSV Tools
Plug 'chrisbra/csv.vim'
" Ansible YAML
Plug 'pearofducks/ansible-vim'
" Terraform HCL and JSON
Plug 'hashivim/vim-terraform'
" Log4
Plug 'vim-scripts/log4j.vim'
" Nginx
Plug 'vim-scripts/nginx.vim'

" ═════════════ Editing ════════════════

" Argument aid
Plug 'PeterRincker/vim-argumentative'
" Alignment aid
Plug 'junegunn/vim-easy-align'
" Table aid
"Plug 'dhruvasagar/vim-table-mode'
" Auto completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Supertab
Plug 'ervandew/supertab'
" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Multiple Cursors
"Plug 'terryma/vim-multiple-cursors'
" delimitmate
Plug 'raimondi/delimitmate'
" ══════════ Version Control ═══════════

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ══════ Integrated Development ════════

" Tag bar
Plug 'majutsushi/tagbar'
" Code Linting
"Plug 'benekastah/neomake'
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" Live Web Preview
"Plug 'jaxbot/browserlink.vim'
" Vim-Go
Plug 'fatih/vim-go'
" Deoplete-Go
Plug 'zchee/deoplete-go', { 'do': 'make'}
" Gocode autocompletion
"Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Deoplete-jedi
Plug 'zchee/deoplete-jedi'
" Go Compiler
"Plug 'rjohnsondev/vim-compiler-go'

call plug#end()

" ════════════════════════╡ scrooloose/nerdtree ╞═══════════════════════════
" Toggle NERDTree
nnoremap <silent> <C-Space> :NERDTreeToggle<CR>

" ════════════════════════╡ chriskempson/base16-vim ╞═══════════════════════════
let base16colorspace=256

" ════════════════════════╡ vim-airline/vim-airline ╞═══════════════════════════
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#hunks#hunk_symbols = [' ', ' ', ' ']
let airline#extensions#default#section_use_groupitems = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#csv#enabled = 1

" ════════════════════════╡ junegunn/vim-easy-align ╞═══════════════════════════
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ════════════════════════╡ airblade/vim-gitgutter ╞════════════════════════════
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''


" ═══════════════════════════╡ w0rp/ale ╞═════════════════════════════
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 0

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_enabled = 1
let g:ale_lint_delay = 200
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_linter_aliases = {}
let g:ale_linters = {}
let g:ale_set_highlights = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_signs = 1
let g:ale_sign_column_always = 0
let g:ale_sign_offset = 1000000
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
let g:ale_warn_about_trailing_whitespace = 1

" ═══════════════════════════╡ benekastah/neomake ╞═════════════════════════════
"call neomake#configure#automake('w')
"let g:neomake_c_enabled_makers = ['gcc']
"autocmd! BufWritePost,BufEnter * Neomake
"let g:neomake_logfile='/tmp/error.log'
"let g:neomake_open_list = 2
"let g:neomake_error_sign = { 'text': '', 'texthl': 'NeoErrorMsg' }
"let g:neomake_warning_sign = { 'text': '', 'texthl': 'NeoWarningMsg' }
"let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
"let g:neomake_go_gometalinter_maker = {
"  \ 'args': [
"  \   '--tests',
"  \   '--enable-gc',
"  \   '--concurrency=4',
"  \   '--fast',
"  \   '-D', 'aligncheck',
"  \   '-D', 'dupl',
"  \   '-D', 'gocyclo',
"  \   '-D', 'gotype',
"  \   '-E', 'errcheck',
"  \   '-E', 'misspell',
"  \   '-E', 'unused',
"  \   '%:p:h',
"  \ ],
"  \ 'append_file': 0,
"  \ 'errorformat':
"  \   '%E%f:%l:%c:%trror: %m,' .
"  \   '%W%f:%l:%c:%tarning: %m,' .
"  \   '%E%f:%l::%trror: %m,' .
"  \   '%W%f:%l::%tarning: %m'
"  \ }

" ════════════════════════════╡ Shougo/deoplete ╞═══════════════════════════════

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns['default'] = '\h\w*'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1
"let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" ════════════════════════════╡ Supertab ╞═══════════════════════════════

let g:SuperTabLongestHighlight = 1
let g:SuperTabDefaultCompletionType = "<c-p>"

" ══════════════════════╡ rjohnsondev/vim-compiler-go ╞════════════════════════
let g:golang_goroot = "/usr/lib/go"


" ══════════════════════╡ Raimondi/delimitMate ╞════════════════════════
let g:delimitMate_autoclose = 1
let g:delimitMate_matchpairs = "(:),[:],{:},<:>"
let g:delimitMate_jump_expansion = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_inside_quotes = 1


" ══════════════════════╡ SirVer/ultisnips ╞════════════════════════
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:UltiSnipsJumpForwardTrigger = "<tab>"

" ══════════════════════╡ ctrlpvim/ctrlp.vim ╞════════════════════════
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = ''

" ══════════════════════╡ set leader key before plugins ╞════════════════════════

let mapleader = " "

" ══════════════════════╡ easymotion/vim-easymotion ╞════════════════════════

" Change to <Leader> from <Leader><Leader>
map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" ════════════════════════════╡ fatih/vim-go ╞═══════════════════════════════
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_calls = 1

let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_def_mode = 'guru'
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 0

" if enabled this overrides existing mappings
let g:go_def_mapping_enabled = 0

" Dependent on Ctrl+P
au FileType go nmap <leader>gt :GoDeclsDir<cr>

au FileType go nmap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gp <Plug>(go-def-pop)

au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" or open in a browser...
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gl <Plug>(go-metalinter)
au FileType go nmap <Leader>gc <Plug>(go-callers)
au FileType go nmap <Leader>d :GoDecls<CR>

" ════════════════════════════╡ majutsushi/tagbar ╞═══════════════════════════════

nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" ╭────────────────────────────────────────────────────────────────────────────╮
" │                              General Config                                │
" ╰────────────────────────────────────────────────────────────────────────────╯

" ═══════════════════════════╡ Performance Tweaks ╞═════════════════════════════

" Reduce mode change delay
set timeout ttimeout
set timeoutlen=1000 ttimeoutlen=0
" Don't redraw screen for non-typed macros
"set lazyredraw

" ═══════════════════════════════╡ Proofing ╞═══════════════════════════════════

"" Create directory on save
"function WriteCreatingDirs()
"    execute ':silent !mkdir -p %:h'
"    write
"endfunction
"command W call WriteCreatingDirs()

" ═══════════════════════════════╡ Appearance ╞═════════════════════════════════
"
" No sounds
set visualbell
" Simple window title
"set titlestring=nvim
" Relative line numbers
set relativenumber
" Show current line number
set number
" Show command key presses in bottom right
set showcmd
" Don't show current mode down the bottom
set noshowmode
" Highlight current line
set cursorline
" Higlight matching parenthesis
set showmatch
" Only highlight cursorline for focused buffer on focused window.
autocmd FocusLost *     :set nocursorline
autocmd FocusGained *   :set cursorline
autocmd WinLeave *      :set nocursorline
autocmd WinEnter *      :set cursorline
" Split windows to the right and to the bottom
set splitright
set splitbelow

" Make it easier to work with buffers
" http://vim.wikia.com/wiki/Easier_buffer_switching
set hidden
set confirm
set autowriteall
set wildmenu wildmode=full

" Interface update time
set updatetime=100

" ═══════════════════════════════╡ Navigation ╞═════════════════════════════════

" Synchronise registers between windows
autocmd CursorHold,FocusGained,FocusLost * rshada|wshada

"" Use Alt+hjkl as arrow keys
noremap <M-h> <Left>
noremap! <M-h> <Left>
noremap <M-j> <Down>
noremap! <M-j> <Down>
noremap <M-k> <Up>
noremap! <M-k> <Up>
noremap <M-l> <Right>
noremap! <M-l> <Right>

"autoclose location list on file exist
autocmd QuitPre * | silent! lclose

" location list navigator
nmap <c-n> :lnext<CR>
nmap <c-m> :lprev<CR>
nmap <c-b> :ll<CR>

" improved keyboard navigation
"nnoremap <leader>h <C-w>h
"nnoremap <leader>j <C-w>j
"nnoremap <leader>k <C-w>k
"nnoremap <leader>l <C-w>l

" Split pane navigation (now handled by tmux-navigation)
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-l> <c-w>l
"nnoremap <c-h> <c-w>h

" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb <C-^>

"" go to next buffer
"nnoremap <silent> <leader>bn :bn<CR>
nnoremap <C-Right> :bn<CR>

"" go to previous buffer
"nnoremap <silent> <leader>bp :bp<CR>
"" https://github.com/neovim/neovim/issues/2048
nnoremap <C-Left> :bp<CR>

"" close buffer
nnoremap <silent> <leader>bd :bd<CR>

"" kill buffer
nnoremap <silent> <leader>bk :bd!<CR>
"
"" list buffers
nnoremap <silent> <leader>bl :ls<CR>
"" list and select buffer
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>
"
"" horizontal split with new buffer
nnoremap <silent> <leader>bh :new<CR>
"
"" vertical split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>

" redraw screan and clear search highlighted items
"http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
"nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" ═══════════════════════════════╡ misc remaps ╞═════════════════════════════════

" toggle line numbers
nnoremap <silent> <leader>n :set number! number?<CR>


" ═══════════════════════════════╡ auto completion ╞═════════════════════════════════
set completeopt+=noinsert
set completeopt+=noselect

" ═══════════════════════════════╡ Whitespace ╞═════════════════════════════════

" Width of <tab> characters measured in <spaces>
set tabstop=4
" Use <spaces> when inserting <tabs>
set expandtab
" Amount of <spaces> to insert when pressing <tab>
set softtabstop=4
" Amount of <spaces> to shift indentation (>>)
set shiftwidth=4
" Show/Hide invisible characters with \+l
nmap <leader><leader>l :set list!<CR>
" Set custom characters for showing invisibles
set listchars=tab:→\ ,space:·,eol:↵
" Auto indent pasted text
"nnoremap p p=`]<C-o>
" Auto indent pasted text
"nnoremap P P=`]<C-o>
" Delete trailing whitespace upon saving
autocmd BufWritePre * %s/\s\+$//e

" ═══════════════════════════════╡ Searching ╞══════════════════════════════════

" Ignore case when searching
set ignorecase

" ════════════════════════════════╡ Folding ╞═══════════════════════════════════

" Open & close with spacabar
nnoremap <Leader><space> za
" fold based on indent level
set foldmethod=indent
" max 10 dept
set foldnestmax=10
" start with fold level of 1
set foldlevelstart=10

" ═════════════════════════════════╡ Colors ╞═══════════════════════════════════

" Enable syntax processing
"syntax enable
" Set 256 terminal colors
set t_Co=256
" Optimize colors for dark background
set background=dark
" Set colorscheme
colorscheme base16-ocean
" Paint margin (see textwidth)
"let &colorcolumn=join(range(100,999),",")

" Custom Search Highlights
highlight Search ctermbg=16 ctermfg=18
highlight IncSearch ctermbg=17 ctermfg=18

" [Plugin] Custom Pandoc syntax colors
"highlight pandocAtxHeader ctermfg=16 cterm=bold
"highlight pandocAtxStart ctermfg=17
"highlight pandocSetexHeader ctermfg=03 cterm=bold
"highlight pandocStrong ctermfg=21
"highlight pandocStrongEmphasis ctermfg=21 gui=bold,italic cterm=bold,italic
"highlight pandocStrongInEmphasis ctermfg=21 gui=bold,italic cterm=bold,italic
"highlight pandocEmphasisInStrong ctermfg=05 gui=bold,italic cterm=bold,italic
"highlight pandocTableHeaderWord ctermfg=06 cterm=bold
"highlight pandocGridTableDelims ctermfg=06
"highlight pandocGridTableHeader ctermfg=06
"highlight pandocDelimitedCodeBlock ctermfg=02
"highlight pandocHRule ctermfg=19 cterm=bold

" [Plugin] Custom Neomake icon colors
"highlight NeoWarningMsg ctermfg=3 ctermbg=18
"highlight NeoErrorMsg ctermfg=1 ctermbg=18

"" Show syntax highlighting groups for word under cursor - Ctrl+Shift+p
"function! <SID>SynStack()
"    if !exists("*synstack")
"        return
"    endif
"    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
"endfunc
"nmap <C-S-P> :call <SID>SynStack()<CR>


" ═══════════════════════════╡ Yaml ╞═════════════════════════════
au FileType yaml setl sw=2 sts=2 ts=2
