" -------------
" Vundle
" https://github.com/gmarik/Vundle.vim
" -------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
""Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
""Plugin 'L9'
" Git plugin not hosted on GitHub
""Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
""Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
""Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
""Plugin 'user/L9', {'name': 'newL9'}

" Install Vim-go
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set tabstop=4
set shiftwidth=4
set cindent
syntax enable
syntax on
set t_Co=256
colorscheme desert

" Vim syntax file
" Language: 	YANG
" Remark:		RFC 6020 http://tools.ietf.org/html/rfc6020
" Version: 		1
" Last Change:	2011 Sep 28
" Maintainer: 	Matt Parker <mparker@computer.org>
"------------------------------------------------------------------

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" yang has keywords with a '-' in them
setlocal iskeyword+=-

" keywords are case-sensitive
syn case match

" enable block folding
syn region yangBlock start="{" end="}" fold transparent


" built-in types (section 4.2.4)
syn keyword yangType decimal64 int8 int16 int32 int64 uint8 uint16 uint32 uint64
syn keyword yangType string boolean enumeration bits binary leafref identityref empty instance-identifier

syn match yangIdentifier /\c\<\h\+[A-Za-z0-9_-]*\>/

" identifiers must not begin with 'xml'. this rule must be defined after the previous yangIdentifier to work properly.
syn match yangBadIdentifier /\c\<xml\(\h\+[A-Za-z0-9_-]\)*\>/

" statement keywords
syn keyword yangStatement anyxml argument augment base belongs-to bit case choice
syn keyword yangStatement config contact container default description enum error-app-tag error-message
syn keyword yangStatement extension deviation deviate feature fraction-digits grouping identity
syn keyword yangStatement import include input key leaf leaf-list length
syn keyword yangStatement list mandatory max-elements min-elements module must namespace
syn keyword yangStatement notification ordered-by organization output path pattern position
syn keyword yangStatement prefix presence range reference refine require-instance revision
syn keyword yangStatement revision-date rpc status submodule type typedef unique
syn keyword yangStatement units uses value when yang-version yin-element 

" other keywords
syn keyword yangOther add current delete deprecated max min not-supported
syn keyword yangOther obsolete replace system unbounded user

" boolean constants (separated from the 'other keywords' for vim syntax purpose)
syn keyword yangBoolean true false

" if-feature (separated from 'statement keywords' for vim syntax purposes)
syn keyword yangConditional if-feature

" comments
syn region yangComment start=/\/\*/ end=/\*\//
syn region yangComment start="//" end="$" 

" strings
syn region yangString start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region yangString start=+'+ skip=+\\\\\|\\'+ end=+'+

" dates
syn match yangDateArg /"\=\<\d\{4}-\d\{2}-\d\{2}\>"\=/

" length-arg TODO: this needs to also include the pipe and individual numbers (i.e. fixed length)
syn match yangLengthArg /"\(\d\+\|min\)\s*\.\.\s*\(\d\+\|max\)"/

" numbers
syn match yangNumber /\<[+-]\=\d\+\>/
syn match yangNumber	"\<0x\x\+\>"


"-------------------------------------
" and now for the highlighting

" things with one-to-one mapping
hi def link yangBadIdentifier Error
hi def link yangIdentifier Identifier
hi def link yangString String
hi def link yangComment Comment
hi def link yangNumber Number
hi def link yangBoolean Boolean
hi def link yangConditional Conditional
hi def link yangType Type

" arbitrary mappings
hi def link yangKeyword Type
hi def link yangStatement Type
hi def link yangModule Type
hi def link yangDateArg Conditional
hi def link yangLengthArg Conditional

let b:current_syntax = "yang"

