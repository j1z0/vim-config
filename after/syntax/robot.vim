"=============================================================================
" File:         after/syntax/robot.vim
" Author:       Michael Foukarakis
" Version:      0.0.6
" Created:      Fri 17 Dec 2010 11:31:46 AM EET
" Last Update: Fri Aug 05, 2011 18:37 GTB Daylight Time
"------------------------------------------------------------------------
" Description:
"       Syntax file for Robot test framework files.
"
"------------------------------------------------------------------------
" Installation:
"       Drop this file into {rtp}/after/syntax
"       Requires Vim 7+
" History:
"   * 0.0.6 - Only highlight built-ins on word boundaries.
"   * 0.0.5 - Highlights table headers correctly. Added settings for
"   the various tables.
"   * 0.0.4 - Removed leading slashes from path regexp. Restricted to
"           eol, to avoid matching common usage of slash.
"           - Rudimentary string matching.
" TODO:
"       * Links look OK in most of my colorschemes, but your opinions are
"       more than welcome.
"       * Fix word boundaries for numbers.
"       * Figure out a neater alternative for the monster path regex
"       * Robot user guide is a bit foggy on the specs of the syntax. Need
"       clarifications..
"=============================================================================
let s:cpo_save=&cpo
set cpo&vim
"------------------------------------------------------------------------
" Matches
"------------------------------------------------------------------------
syn match robotNumber           display "\<\d\+\>"
syn match robotEllipsis         display "\.\.\."
" Special (escaped) character as defined in Robot's syntax.
syn match robotSpecial          display "\\\(\${.*}\|\\\|#\|[n|r|t]\)"
" As variables may be used next to each other, do a non-greedy match.
" Alternatively, match only alphanumeric chars inside brackets.
syn match robotVariable     "\${.\{-}}"
" This is actually NSN specific, keep/change/delete it at will.
" syn match robotTestCaseName     "^NG\d\+[ \|\n\|\t]"
" This is by far the most stupid regex you'll see in here..
syn match robotPath             display "\(\.\{1,2}\/\)\=\(\(\h\|\d\)\+\/\)\+\(\(\h\|\d\)\+\.\h\+\)\{,1}$"
" Operators
syn match robotOperator     "==\|="
" Table headers
syn match robotTable        "\c^\(\*\+\)\s*\(settings\|variables\|test cases\|\(user \)\?keywords\)\s*\1$"
" Builtins
syn match robotBuiltin      "\c\<\(Call Method\|Catenate\|Comment\|Convert To Boolean\|Convert To Integer\|Convert To Number\|Convert To String\|Create List\|Evaluate\|Exit For Loop\|Fail\|Fatal Error\|Get Count\|Get Length\|Get Library Instance\|Get Time\|Get Variables\|Import Library\|Import Resource\|Import Variables\|Length Should Be\|Log\|Log Many\|Log Variables\|No Operation\|Regexp Escape\|Remove Tags\|Repeat Keyword\|Replace Variables\|Run Keyword\|Run Keyword And Continue On Failure\|Run Keyword And Expect Error\|Run Keyword And Ignore Error\|Run Keyword If\|Run Keyword If All Critical Tests Passed\|Run Keyword If All Tests Passed\|Run Keyword If Any Critical Tests Failed\|Run Keyword If Any Tests Failed\|Run Keyword If Test Failed\|Run Keyword If Test Passed\|Run Keyword If Timeout Occurred\|Run Keyword Unless\|Run Keywords\|Set Global Variable\|Set Library Search Order\|Set Log Level\|Set Suite Variable\|Set Tags\|Set Test Message\|Set Test Variable\|Set Variable\|Set Variable If\|Should Be Empty\|Should Be Equal\|Should Be Equal As Integers\|Should Be Equal As Numbers\|Should Be Equal As Strings\|Should Be True\|Should Contain\|Should Contain X Times\|Should End With\|Should Match\|Should Match Regexp\|Should Not Be Empty\|Should Not Be Equal\|Should Not Be Equal As Integers\|Should Not Be Equal As Numbers\|Should Not Be Equal As Strings\|Should Not Be True\|Should Not Contain\|Should Not End With\|Should Not Match\|Should Not Match Regexp\|Should Not Start With\|Should Start With\|Sleep\|Variable Should Exist\|Variable Should Not Exist\|Wait Until Keyword Succeeds\)\>"
" Common settings
syn match robotCommonSet    "\c\[\(Documentation\|Timeout\)\]"
" Keyword settings
syn match robotKeywordSet   "\c\[\(Arguments\|Return\)\]"
" Testcase settings
syn match robotTestcaseSet  "\c\[\(Tags\|Setup\|Teardown\|Precondition\|Postcondition\|Template\)\]"
" Settings (global)
syn match robotSetup        "\c\(Suite\|Test\) \(Setup\|Teardown\|Precondition\|Postcondition\)"
syn match robotSettings     "\c\(Library\|Resource\|Variables\|Documentation\|Metadata\|Force Tags\|Default Tags\|Test Template\|Test Timeout\)"
" Other libraries (Selenium)
syn match seleniumLibrary   "\c\<\(Add Location Strategy\|Alert Should Be Present\|Assign Id To Element\|Call Selenium Api\|Capture Page Screenshot\|Capture Screenshot\|Checkbox Should Be Selected\|Checkbox Should Not Be Selected\|Choose Cancel On Next Confirmation\|Choose File\|Click Button\|Click Element\|Click Flex Element\|Click Image\|Click Link\|Close All Browsers\|Close Browser\|Close Window\|Confirm Action\|Current Frame Contains\|Current Frame Should Contain\|Delete All Cookies\|Delete Cookie\|Double Click Element\|Double Click Flex Element\|Drag And Drop\|Element Should Be Disabled\|Element Should Be Enabled\|Element Should Be Visible\|Element Should Contain\|Element Should Not Be Visible\|Element Text Should Be\|Execute Javascript\|Flex Element Property Should Be\|Flex Element Should Exist\|Flex Element Should Not Exist\|Flex Element Text Should Be\|Focus\|Frame Should Contain\|Frame Should Contain Text\|Get Alert Message\|Get All Links\|Get Cookie Value\|Get Cookies\|Get Element Attribute\|Get Horizontal Position\|Get List Items\|Get Location\|Get Matching Xpath Count\|Get Source\|Get Table Cell\|Get Text\|Get Title\|Get Value\|Get Vertical Position\|Get Window Identifiers\|Get Window Names\|Get Window Titles\|Go Back\|Go To\|Input Password\|Input Text\|Input Text Into Flex Element\|List Selection Should Be\|List Should Have No Selections\|Location Should Be\|Location Should Contain\|Log Source\|Maximize Browser Window\|Mouse Down\|Mouse Down On Image\|Mouse Down On Link\|Mouse Out\|Mouse Over\|Mouse Up\|Open Browser\|Open Context Menu\|Page Should Contain\|Page Should Contain Button\|Page Should Contain Checkbox\|Page Should Contain Element\|Page Should Contain Image\|Page Should Contain Link\|Page Should Contain List\|Page Should Contain Radio Button\|Page Should Contain Textfield\|Page Should Not Contain\|Page Should Not Contain Button\|Page Should Not Contain Checkbox\|Page Should Not Contain Element\|Page Should Not Contain Image\|Page Should Not Contain Link\|Page Should Not Contain List\|Page Should Not Contain Radio Button\|Page Should Not Contain Textfield\|Press Key\|Press Key Native\|Radio Button Should Be Set To\|Radio Button Should Not Be Selected\|Register Keyword To Run On Failure\|Reload Page\|Select All From List\|Select Checkbox\|Select Flex Application\|Select Frame\|Select From Flex Element\|Select From List\|Select Radio Button\|Select Window\|Set Selenium Speed\|Set Selenium Timeout\|Simulate\|Start Selenium Server\|Stop Selenium Server\|Submit Form\|Switch Browser\|Table Cell Should Contain\|Table Column Should Contain\|Table Footer Should Contain\|Table Header Should Contain\|Table Row Should Contain\|Table Should Contain\|Textfield Should Contain\|Textfield Value Should Be\|Title Should Be\|Unselect Checkbox\|Unselect Frame\|Unselect From List\|Wait For Condition\|Wait For Flex Element\|Wait Until Page Contains\|Wait Until Page Contains Element\|Wait Until Page Loaded\|Xpath Should Match X Times\)\>"

"------------------------------------------------------------------------
" Regions
"------------------------------------------------------------------------
" Single-line comments. Are there multi-line comments?
syn region robotComment         display start="^#" excludenl end="$"
syn region robotString          start="\"" excludenl end="\""

"------------------------------------------------------------------------
" Keywords
"------------------------------------------------------------------------

"------------------------------------------------------------------------
" Links
"------------------------------------------------------------------------
hi def link robotVariable   Type
hi def link robotSetup      Include
hi def link robotSettings   Include
hi def link robotTestCaseName   Function
hi def link robotComment    Comment
hi def link robotEllipsis   String
hi def link robotTable      Identifier
hi def link robotImport     Include
hi def link robotSpecial    Special
hi def link robotString     String
hi def link robotNumber     Number
hi def link robotPath       Constant
hi def link robotOperator   Operator
hi def link robotBuiltin    Comment
hi def link robotCommonSet  Keyword
hi def link robotKeywordSet Keyword
hi def link robotTestcaseSet    Keyword
hi def link seleniumLibrary Keyword

let b:current_syntax = "robot"
"------------------------------------------------------------------------
let &cpo=s:cpo_save
" vim600: set fdm=marker:
