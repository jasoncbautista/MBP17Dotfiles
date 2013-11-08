" Pathogen: plugin manager
execute pathogen#infect()

" Our meain Leader meta character is the comma
let mapleader = ","
" :set t_Co=256
nmap <leader>W :set t_Co=256 <ENTER>


set fileencoding=utf-8
set fileencodings=utf-8
set encoding=utf-8
set termencoding=utf-8
" TODO: flush cash from command T on write!!
call pathogen#infect() " Not sure what this does
" Instead of hitting the ESC key we use jk  
imap jk <ESC>

" Show invisible characters
set list

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬



" We want to show line numbers: 
set number

" Our tags are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4 " ???
set expandtab " ?? Makes tabs into spaces 

" This is need for when deleting from insert mode:
set backspace=2 
set nocompatible " ??


" Want syntax highlighting on by  default:
syntax on
" Trying to make indent work correctly JS:
"set syntax
"et filetype
filetype indent on
filetype plugin indent on


"Sets search highlignting on 
set hlsearch 
set cpoptions+=$ "????


" Warns us for width of columns
set colorcolumn=80 

"Matching parens
" Set auto indent  so new lines created same indent as previous
set autoindent 

" Here we have some mappings to build a specific directory for work:
" NOTE: Would be best if this only got triggered when in these directories
" When in insert mode:
imap <F2> <ESC>:w<ENTER>:!/Users/jasonify/Mailfoo/builders/build.sh "/Users/jasonify/Mailfoo" "true" "false" "false" <ENTER>

map <F2> :w<ENTER>:!/Users/jasonify/Mailfoo/builders/build.sh "/Users/jasonify/Mailfoo" "true" "false" "false" <ENTER>

" Create var self = this;
map <Leader>E o  var self = this;
imap <C-e>  <ESC>$i <ENTER>var self = this;



" An experiment to test if we can auto write a js function
" WARNING: the last four spaces are hardcoded.. SHOLD NOT BE!!!:
imap <C-f>   : function() { <ENTER>var self = this;<ENTER>}, <ESC><Ctr-<><O



" Sorrounds stuff under cursor with _.isReal
imap <leader>r  <ESC>I if( _.isReal( <ESC>A ) ) {<ENTER>}  <ESC><Ctr-<><O
nmap <leader>r  <ESC>I if( _.isReal( <ESC>A ) ) {  <ENTER>} <ESC><Ctr-<><O

" Sorround stuff under cursor with _.each
imap <leader>e  <ESC>I _.each( <ESC>A, function(
map <leader>e  <ESC>I _.each( <ESC>A, function(

" Close up each:
imap <leader>E  <ESC>A){<ENTER>});  <ESC>O
map <leader>E  <ESC>A){<ENTER>});  <ESC>O

"  Sorround stuff under cursor with map
imap <leader>m  <ESC>I _.map(<ESC>A, function(value, key){<ENTER>});<ESC>O
map <leader>m  <ESC>I _.map(<ESC>A, function(value, key){<ENTER>});<ESC>O

 
" Misspelled words fixed automatically
iabbrev teh the
iabbrev Teh The
iabbrev sefl self 

" Set our default color scheme:
colorscheme monokai
" colorscheme desert

" We want to enable different color schemes depnding on filetype:
" ~/.vim/ftplugin/javascript.vim
filetype plugin on 


" Start the Nerd Tree .. really sweet:
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p



" Formatting text utilyt: must install par
" gqip   
" gwip for old
set formatprg=par


" Make vim add new comments on new line when in insert mode:
set formatoptions+=r



" Generate doc comment template
" Source;
"   http://stackoverflow.com/questions/7942738/vim-plugin-to-generate-javascript-documentation-comments
" NOTE: Slightly modified 
map <Leader>/ :call GenerateDOCComment()<cr>


" Fix whiitepaces at end of lines:
autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()


function! GenerateDOCComment()
  let l    = line('.')
  let i    = indent(l)
  let pre  = repeat(' ',i)
  let text = getline(l)
  let params   = matchstr(text,'([^)]*)')
  let paramPat = '\([$a-zA-Z_0-9]\+\)[, ]*\(.*\)'
  echomsg params
  let vars = []
  let m    = ' '
  let ml = matchlist(params,paramPat)
  while ml!=[]
    let [_,var;rest]= ml
    let vars += [pre.' * @param {type} '.var .',']
    let ml = matchlist(rest,paramPat,0)
  endwhile
  let vars += [pre.' * @return {Null}' ]
  let comment = [pre.'/**',pre.' * '] + vars + [pre.' */']
  call append(l-1,comment)
  call cursor(l+1,i+3)
endfunction


function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


" TOO BUGY: 
" Source the vimrc file after saving it
"if has("autocmd")
"  autocmd bufwritepost .vimrc source $MYVIMRC
"endif

" Open vimrc with Leader + v
let mapleader = ","
nmap <leader>V :tabedit $MYVIMRC<CR>




" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc



" Make under cursor private:
" map <Leader>u  :%s/<c-r><c-w>/_<c-r><c-w>/g<enter>



" Toggle spell checking on and off with `,s`
let mapleader = ","
nmap <silent> <leader>s :set spell!<CR>
 
" Set region to American English (US)
set spelllang=en_us


" Add block when pressing o in normal mode:
set formatoptions+=o
" This is for block comments when in insert mode / edit
set formatoptions+=r


" HTML Auto Complete: sparkup
" Usage:
"   ul > li.item-$*3
"   <C-e>



" Sorround word under cursor with single quotes
map <leader>' ciw'<ESC>pa'<ESC>

" Sorround word under cursor with double quotes
map <leader>" ciw"<ESC>pa"<ESC>



" Search vim:
"
"
"
" :vimgrep /pattern/ **/*.js **/*.css
" :cnext
" :clast
