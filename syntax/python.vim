" Vim syntax file
" Language:	Python
" Maintainer: Ian McCracken <ian.mccracken@gmail.com>
" Filenames:	*.py
"
" Based on python.vim by Dmitry Vasiliev <dima@hlabs.spb.ru>
"
" Includes support for:
"   * Highlighting of 'self' convention
"   * Separation of docstrings and other comments/strings
"   * Assignment
"   * Improved class/function highlighting, including arguments and base classes
"
"
" Options:
"
"    For set option do: let OPTION_NAME = 1
"    For clear option do: let OPTION_NAME = 0
"
" Option names:
"
"    For highlight builtin functions:
"       python_highlight_builtins
"
"    For highlight standard exceptions:
"       python_highlight_exceptions
"
"    For highlight string formatting:
"       python_highlight_string_formatting
"
"    For highlight str.format syntax:
"       python_highlight_string_format
"
"    For highlight string.Template syntax:
"       python_highlight_string_templates
"
"    For highlight indentation errors:
"       python_highlight_indent_errors
"
"    For highlight trailing spaces:
"       python_highlight_space_errors
"
"    For highlight doc-tests:
"       python_highlight_doctests
"
"    If you want all possible Python highlighting:
"    (This option not override previously set options)
"       python_highlight_all
"
"    For fast machines:
"       python_slow_sync
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if exists("python_highlight_all") && python_highlight_all != 0
  " Not override previously set options
  if !exists("python_highlight_builtins")
    let python_highlight_builtins = 1
  endif
  if !exists("python_highlight_exceptions")
    let python_highlight_exceptions = 1
  endif
  if !exists("python_highlight_string_formatting")
    let python_highlight_string_formatting = 1
  endif
  if !exists("python_highlight_string_format")
    let python_highlight_string_format = 1
  endif
  if !exists("python_highlight_string_templates")
    let python_highlight_string_templates = 1
  endif
  if !exists("python_highlight_indent_errors")
    let python_highlight_indent_errors = 1
  endif
  if !exists("python_highlight_space_errors")
    let python_highlight_space_errors = 1
  endif
  if !exists("python_highlight_doctests")
    let python_highlight_doctests = 1
  endif
endif

" Keywords
syn keyword pythonStatement	break continue del
syn keyword pythonStatement	exec return
syn keyword pythonStatement	pass print raise
syn keyword pythonStatement	global assert
syn keyword pythonStatement	yield lambda
syn keyword pythonStatement	with

" Class definitions
syn region  pythonClass start="^\s*class" end=")\s*:" contains=pythonClassDef,pythonClassName,pythonSuperclasses
syn keyword pythonClassDef class contained nextgroup=pythonClassName
syn match   pythonClassName	"[a-zA-Z_][a-zA-Z0-9_]*" display contained nextgroup=pythonSuperclasses skipwhite
syn region  pythonSuperclasses start="("ms=s+1 end=")"me=e-1 keepend contained contains=pythonSuperclass transparent
syn match   pythonSuperclass "[a-zA-Z_][a-zA-Z_0-9]*" contained

" Function definitions
syn region  pythonFunc start="^\s*def\>" end=")\s*:" keepend contains=pythonFuncDef,pythonFuncName,pythonFuncParams
syn keyword pythonFuncDef def contained nextgroup=pythonFuncName skipwhite
syn match   pythonFuncName	"[a-zA-Z_][a-zA-Z0-9_]*" display contained nextgroup=pythonFuncParams skipwhite
syn region  pythonFuncParams start="("ms=s+1 end=")"me=e-1 contained transparent contains=pythonParam 
syn region   pythonParam start="[a-zA-Z_]" end="\(,\|)\s*:\)" contained contains=pythonParamName,pythonParamDefault,pythonDefaultAssignment transparent nextgroup=pythonParam
syn match pythonParamName "[a-zA-Z_][a-zA-Z0-9_]*" contained nextgroup=pythonDefaultAssignment skipwhite skipnl
syn match pythonDefaultAssignment "=" nextgroup=pythonParamDefault skipwhite contained skipnl

syn match pythonParamDefault "=\@<=[^,]*" contained transparent contains=@pythonStringType,@pythonNumberType,@pythonBuiltin,pythonKeyword

syn keyword pythonRepeat	for while
syn keyword pythonConditional	if elif else
syn keyword pythonPreCondit	import from as
syn keyword pythonException	try except finally
syn keyword pythonOperator	and in is not or 

syn match pythonAssignment "+=\|-=\|\*=\|/=\|//=\|%=\|&=\||=\|\^=\|>>=\|<<=\|\*\*="
syn match pythonAssignment "="
syn match pythonArithmetic "+\|-\|\*\|\*\*\|/\|//\|%\|<<\|>>\|&\||\|\^\|\~"
syn match pythonComparison "<\|>\|<=\|>=\|==\|!=\|<>"


" Decorators (new in Python 2.4)
syn match   pythonDecorator	"@" display nextgroup=pythonFunction skipwhite

" Comments
syn match   pythonComment	"#.*$" display contains=pythonTodo,@Spell
syn match   pythonRun		"\%^#!.*$"
syn match   pythonCoding	"\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword pythonTodo		TODO FIXME XXX contained

" Errors
syn match pythonError		"\<\d\+\D\+\>" display
syn match pythonError		"[$?]" display
syn match pythonError		"[&|]\{2,}" display
syn match pythonError		"[=]\{3,}" display

" TODO: Mixing spaces and tabs also may be used for pretty formatting multiline
" statements. For now I don't know how to work around this.
if exists("python_highlight_indent_errors") && python_highlight_indent_errors != 0
  syn match pythonIndentError	"^\s*\( \t\|\t \)\s*\S"me=e-1 display
endif

" Trailing space errors
if exists("python_highlight_space_errors") && python_highlight_space_errors != 0
  syn match pythonSpaceError	"\s\+$" display
endif


" Strings
syn region pythonString		start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
syn region pythonString		start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonEscapeError,@Spell
syn region pythonString		start=+"""+ end=+"""+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonString		start=+'''+ end=+'''+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest,pythonSpaceError,@Spell

syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError

syn match  pythonEscape		+\\[abfnrtv'"\\]+ display contained
syn match  pythonEscape		"\\\o\o\=\o\=" display contained
syn match  pythonEscapeError	"\\\o\{,2}[89]" display contained
syn match  pythonEscape		"\\x\x\{2}" display contained
syn match  pythonEscapeError	"\\x\x\=\X" display contained
syn match  pythonEscape		"\\$"

" Unicode strings
syn region pythonUniString	start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
syn region pythonUniString	start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,@Spell
syn region pythonUniString	start=+[uU]"""+ end=+"""+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonUniString	start=+[uU]'''+ end=+'''+ keepend contains=pythonEscape,pythonUniEscape,pythonEscapeError,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell

syn match  pythonUniEscape	"\\u\x\{4}" display contained
syn match  pythonUniEscapeError	"\\u\x\{,3}\X" display contained
syn match  pythonUniEscape	"\\U\x\{8}" display contained
syn match  pythonUniEscapeError	"\\U\x\{,7}\X" display contained
syn match  pythonUniEscape	"\\N{[A-Z ]\+}" display contained
syn match  pythonUniEscapeError	"\\N{[^A-Z ]\+}" display contained

" Raw strings
syn region pythonRawString	start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString	start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString	start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
syn region pythonRawString	start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn match pythonRawEscape	+\\['"]+ display transparent contained

" Unicode raw strings
syn region pythonUniRawString	start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
syn region pythonUniRawString	start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,pythonUniRawEscape,pythonUniRawEscapeError,@Spell
syn region pythonUniRawString	start=+[uU][rR]"""+ end=+"""+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonUniRawString	start=+[uU][rR]'''+ end=+'''+ keepend contains=pythonUniRawEscape,pythonUniRawEscapeError,pythonDocTest,pythonSpaceError,@Spell

syn match  pythonUniRawEscape		"\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match  pythonUniRawEscapeError	"\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

if exists("python_highlight_string_formatting") && python_highlight_string_formatting != 0
  " String formatting
  syn match pythonStrFormatting	"%\(([^)]\+)\)\=[-#0 +]*\d*\(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrFormatting	"%[-#0 +]*\(\*\|\d\+\)\=\(\.\(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
endif

if exists("python_highlight_string_format") && python_highlight_string_format != 0
  " str.format syntax
  syn match pythonStrFormat "{{\|}}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrFormat	"{\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)\(\.[a-zA-Z_][a-zA-Z0-9_]*\|\[\(\d\+\|[^!:\}]\+\)\]\)*\(![rs]\)\=\(:\({\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)}\|\([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*\(\.\d\+\)\=[bcdeEfFgGnoxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
endif

if exists("python_highlight_string_templates") && python_highlight_string_templates != 0
  " String templates
  syn match pythonStrTemplate	"\$\$" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrTemplate	"\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
  syn match pythonStrTemplate	"\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString
endif

if exists("python_highlight_doctests") && python_highlight_doctests != 0
  " DocTests
  syn region pythonDocTest	start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
  syn region pythonDocTest2	start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained
endif

" Numbers (ints, longs, floats, complex)
syn match   pythonHexError	"\<0[xX]\x*[g-zG-Z]\x*[lL]\=\>" display

syn match   pythonHexNumber	"\<0[xX]\x\+[lL]\=\>" display
syn match   pythonOctNumber "\<0[oO]\o\+[lL]\=\>" display
syn match   pythonBinNumber "\<0[bB][01]\+[lL]\=\>" display

syn match   pythonNumber	"\<\d\+[lLjJ]\=\>" display

syn match   pythonFloat		"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display

syn match   pythonOctError	"\<0[oO]\=\o*[8-9]\d*[lL]\=\>" display
syn match   pythonBinError	"\<0[bB][01]*[2-9]\d*[lL]\=\>" display

if exists("python_highlight_builtins") && python_highlight_builtins != 0
  " Builtin functions, types and objects
  syn keyword pythonBuiltinObj	True False Ellipsis None NotImplemented self
  syn keyword pythonBuiltinObj	__debug__ __doc__ __file__ __name__ __package__

  syn keyword pythonBuiltinFunc	__import__ abs all any apply
  syn keyword pythonBuiltinFunc	basestring bin bool buffer bytearray bytes callable
  syn keyword pythonBuiltinFunc	chr classmethod cmp coerce compile complex
  syn keyword pythonBuiltinFunc	delattr dict dir divmod enumerate eval
  syn keyword pythonBuiltinFunc	execfile file filter float format frozenset getattr
  syn keyword pythonBuiltinFunc	globals hasattr hash help hex id 
  syn keyword pythonBuiltinFunc	input int intern isinstance
  syn keyword pythonBuiltinFunc	issubclass iter len list locals long map max
  syn keyword pythonBuiltinFunc	min next object oct open ord
  syn keyword pythonBuiltinFunc	pow property range
  syn keyword pythonBuiltinFunc	raw_input reduce reload repr
  syn keyword pythonBuiltinFunc	reversed round set setattr
  syn keyword pythonBuiltinFunc	slice sorted staticmethod str sum super tuple
  syn keyword pythonBuiltinFunc	type unichr unicode vars xrange zip
endif

if exists("python_highlight_exceptions") && python_highlight_exceptions != 0
  " Builtin exceptions and warnings
  syn keyword pythonExClass	BaseException
  syn keyword pythonExClass	Exception StandardError ArithmeticError
  syn keyword pythonExClass	LookupError EnvironmentError

  syn keyword pythonExClass	AssertionError AttributeError BufferError EOFError
  syn keyword pythonExClass	FloatingPointError GeneratorExit IOError
  syn keyword pythonExClass	ImportError IndexError KeyError
  syn keyword pythonExClass	KeyboardInterrupt MemoryError NameError
  syn keyword pythonExClass	NotImplementedError OSError OverflowError
  syn keyword pythonExClass	ReferenceError RuntimeError StopIteration
  syn keyword pythonExClass	SyntaxError IndentationError TabError
  syn keyword pythonExClass	SystemError SystemExit TypeError
  syn keyword pythonExClass	UnboundLocalError UnicodeError
  syn keyword pythonExClass	UnicodeEncodeError UnicodeDecodeError
  syn keyword pythonExClass	UnicodeTranslateError ValueError VMSError
  syn keyword pythonExClass	WindowsError ZeroDivisionError

  syn keyword pythonExClass	Warning UserWarning BytesWarning DeprecationWarning
  syn keyword pythonExClass	PendingDepricationWarning SyntaxWarning
  syn keyword pythonExClass	RuntimeWarning FutureWarning
  syn keyword pythonExClass	ImportWarning UnicodeWarning
endif

if exists("python_slow_sync") && python_slow_sync != 0
  syn sync minlines=2000
else
  " This is fast but code inside triple quoted strings screws it up. It
  " is impossible to fix because the only way to know if you are inside a
  " triple quoted string is to start from the beginning of the file.
  syn sync match pythonSync grouphere NONE "):$"
  syn sync maxlines=200
endif

syn cluster pythonStringType contains=pythonString,pythonUniString,pythonRawString,pythonUniRawString
syn cluster pythonNumberType contains=pythonNumber,pythonHexNumber,pythonFloat
syn cluster pythonBuiltin    contains=pythonBuiltinObj,pythonBuiltinFunc

if version >= 508 || !exists("did_python_syn_inits")
  if version <= 508
    let did_python_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink pythonFuncDef     Statement
  HiLink pythonFuncName    Entity
  HiLink pythonParamName Test
  HiLink pythonDefaultAssignment pythonAssignment
  HiLink pythonParamDefault Statement
  HiLink pythonClassDef     Statement
  HiLink pythonClassName    Entity
  HiLink pythonSuperclass   Entity

  HiLink pythonStatement	Statement
  HiLink pythonPreCondit	Statement
  HiLink pythonFunction		Function
  HiLink pythonConditional	Conditional
  HiLink pythonRepeat		Repeat
  HiLink pythonException	Exception

  HiLink pythonOperator		Operator
  HiLink pythonAssignment	Operator
  HiLink pythonComparison	Operator
  HiLink pythonArithmetic   Operator

  HiLink pythonDecorator	Define

  HiLink pythonComment		Comment
  HiLink pythonDocstring    Comment
  HiLink pythonCoding		Special
  HiLink pythonRun		Special
  HiLink pythonTodo		Todo

  HiLink pythonError		Error
  HiLink pythonIndentError	Error
  HiLink pythonSpaceError	Error

  HiLink pythonString       String
  HiLink pythonUniString    String
  HiLink pythonRawString    String
  HiLink pythonUniRawString String

  HiLink pythonEscape			Special
  HiLink pythonEscapeError		Error
  HiLink pythonUniEscape		Special
  HiLink pythonUniEscapeError		Error
  HiLink pythonUniRawEscape		Special
  HiLink pythonUniRawEscapeError	Error

  HiLink pythonStrFormatting	Special
  HiLink pythonStrFormat	Special
  HiLink pythonStrTemplate	    Special

  HiLink pythonDocTest		Test
  HiLink pythonDocTest2		Test

  HiLink pythonNumber		Number
  HiLink pythonHexNumber	Number
  HiLink pythonOctNumber	Number
  HiLink pythonBinNumber	Number
  HiLink pythonFloat		Float
  HiLink pythonOctError	    Error
  HiLink pythonHexError		Error
  HiLink pythonBinError		Error

  HiLink pythonBuiltinObj   Number
  HiLink pythonBuiltinFunc  Structure

  HiLink pythonExClass	Structure

  delcommand HiLink
endif

let b:current_syntax = "python"
