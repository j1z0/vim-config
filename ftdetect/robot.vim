"=============================================================================
" File:         ftdetect/robot.vim                                {{{1
" Author:       Michael Foukarakis
" Version:      0.2
" Created:      Tue 21 Dec 2010 09:08:35 AM EET
" Last Update:  Fri Jan 07 2011 11:40:26 AM GTB Standard Time
"------------------------------------------------------------------------
" Description:
"       Filetype detection plugin for Robot files.
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/ftdetect
"       Requires Vim7+
" History:
" 		v0.2 - Improved the regexp for Robot headers.
" TODO:         Missing features go here.
" }}}1
"=============================================================================
let s:cpo_save=&cpo
set cpo&vim

au BufNewFile,BufRead *.txt call s:FTrobot()

func! s:FTrobot()
	let b:topl = getline(1)
	if (exists("g:robot_syntax_for_txt") && g:robot_syntax_for_txt)
	\ || b:topl =~ '\c^\(\*\{1,3}\)\s*.\{-}\s*\1$'
	\ || b:topl =~ '^# -\*- coding: robot -\*-$'
		setf robot
	else
		setf human
	endif
endfunc
"------------------------------------------------------------------------
let &cpo=s:cpo_save
" vim600: set fdm=marker:
