"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: grammars
"
grammarCSS3
^'/* CSS3 grammar: */
/* Tokenization: */
ident 				<-	MINUS? nmstart nmchar*
name 				<-	nmchar+
nmstart 				<-	[a-zA-Z] / UNDERSCORE / nonascii / escape
/* The unicode chars larger than \x00FFFF do not produce correct character codes. 
nonascii 			<-	[\x000080-\x00D7FF] / [\x00E000-\x00FFFD] / [\x010000-\x10FFFF] */
nonascii 			<-	[\x000080-\x00D7FF\x00E000-\x00FFFD]
unicode 				<-	BACKSLASH [0-9a-fA-F]{1,6} wc?
escape 				<-	unicode / BACKSLASH [\x000020-\x00007E\x000080-\x00D7FF\x00E000-\x00FFFD\x010000-\x10FFFF]
nmchar 				<-	[a-zA-Z0-9] / MINUS / UNDERSCORE / nonascii / escape
num 				<-	DECIMALDIGIT+ / DECIMALDIGIT* DOT DECIMALDIGIT+
string 				<-	DOUBLEQUOTE (stringchar / SINGLEQUOTE)* DOUBLEQUOTE
					/	SINGLEQUOTE (stringchar / DOUBLEQUOTE)* SINGLEQUOTE
stringchar 			<-	urlchar / [\x000020] / BACKSLASH nl
urlchar 				<-	[\x000009\x000021\x000023-\x000026\x000027-\x00007E] / nonascii / escape
nl 					<-	[\x00000A] / [\x00000D] [\x00000A] / [\x00000D] / [\x00000C]
w 					<-	wc*
wc 					<-	[\x000009] / [\x00000A] / [\x00000C] / [\x00000D] / [\x000020]
/* CSS3 Tokens: */
IDENT 				<-	ident
ATKEYWORD 		<-	AT ident
STRING 			<-	string
HASH 				<-	HASHCHAR name
NUMBER 			<-	num
PERCENTAGE 		<-	num PERCENTSIGN
DIMENSION 			<-	num ident
URI 				<-	cU cR cL OPEN w (string / urlchar*) w CLOSE
UNICODERANGE 	<-	cU PLUS [0-9A-F]{1,6} (MINUS [0-9A-F]{1,6})?
CDO 				<-	"<!--"
CDC 				<-	"-->"
S 					<-	wc+
COMMENT 			<-	FORWARDSLASH ASTERISK [^*]* ASTERISK+ ([^/] [^*]* ASTERISK+)* FORWARDSLASH
FUNCTION 			<-	ident OPEN
INCLUDES 			<-	"~="
DASHMATCH 		<-	"|="
PREFIXMATCH 		<-	"^="
SUFFIXMATCH 		<-	"$="
SUBSTRINGMATCH 	<-	"*="
CHAR 				<-	!(&DOUBLEQUOTE) !(&SINGLEQUOTE) .
BOM 				<-	[\x00FEFF]
 
/* CSS2 grammar follows: */
stylesheet			<-	(CHARSETSYM STRING SEMICOLON)?
						(S / CDO / CDC)* ( import ( CDO S* / CDC S* )* )*
						(namespace (S / CDO / CDC)* )*
						( ( ruleset / media / page ) ( CDO S* / CDC S* )* )*
						S* !.
import 				<-	IMPORTSYM S*
						(STRING / URI) S* medialist? SEMICOLON S*
namespace 			<-	NAMESPACESYM S* (namespaceprefix S*)? (STRING / URI) S*
namespaceprefix 	<-	IDENT
media 				<-	MEDIASYM S* medialist OPENCURLY S* ruleset* CLOSECURLY S*
medialist 			<-	medium ( COMMA S* medium)*
medium 				<-	IDENT S*
page 				<-	PAGESYM S* pseudopage?
						OPENCURLY S* declaration? ( SEMICOLON S* declaration? )* CLOSECURLY S*
pseudopage 		<-	COLON IDENT S*
operator 			<-	FORWARDSLASH S* / COMMA S* /* / EMPTY */
combinator 			<-	PLUS S* / GREATER S* /* / EMPTY */
unaryoperator 		<-	MINUS / PLUS
property 			<-	IDENT S*
ruleset 				<-	selector (COMMA S* selector)*
						OPENCURLY S* (declaration ( SEMICOLON S* declaration? )*)? CLOSECURLY S*
selector 				<-	simpleselector (combinator selector / S+ ( combinator? selector )? )?
simpleselector 		<-	elementname? ( HASH / class / attrib / pseudo )* S*
class 				<-	DOT IDENT
elementname 		<-	IDENT / ASTERISK
attrib 				<-	OPENSQUARE S* IDENT S* ( ( EQUAL / INCLUDES / DASHMATCH ) S* ( IDENT / STRING ) S* )? CLOSESQUARE
pseudo 				<-	COLON ( IDENT / FUNCTION S* (IDENT S*)? CLOSE )
declaration 			<-	property COLON S* expr prio?
prio 				<-	IMPORTANTSYM S*
expr 				<-	term ( operator term )*
term 				<-	unaryoperator? (( PERCENTAGE / LENGTH / EMS / EXS / ANGLE / TIME / FREQ / NUMBER ) S* / function)
					/	(STRING / IDENT / URI / UNICODERANGE) S*
					/	hexcolor
function 				<-	FUNCTION S* expr CLOSE S*
hexcolor 			<-	HASHCHAR h h h
					/	HASHCHAR h h h h h h

/* Lexical Syntax */
h 					<-	[0-9a-fA-F]
CHARSETSYM 		<-	AT cC cH cA cR cS cE cT
IMPORTSYM 		<-	AT cI cM cP cO cR cT
MEDIASYM 			<-	AT cM cE cD cI cA
PAGESYM 			<-	AT cP cA cG cE
FONTFACESYM 		<-	AT cF cO cN cT DASH cF cA cC cE
NAMESPACESYM 	<-	AT cN cA cM cE cS cP cA cC cE
IMPORTANTSYM 	<-	EXCLAMATION w  cI cM cP cO cR cT cA cN cT

EMS 				<-	num cE cM
EXS 				<-	num cE cX
LENGTH 			<-	num (cP cX / cC cM / cM cM / cI cN / cP cT / cP cC)
ANGLE 				<-	num (cD cE cG / cG? cR cA cD)
TIME 				<-	num cM? cS
FREQ 				<-	num cK? cH cZ
DIMEN 				<-	num ident

/* CSS is case-insensitive. Moreover, letters may be expressed in hex form. cA - cZ definitions address this. */
cA 					<-	[aA] / BACKSLASH [0]{0,4} ([46] [1]) nl?
cB 					<-	[bB] / BACKSLASH [0]{0,4} ([46] [2]) nl?
cC 					<-	[cC] / BACKSLASH [0]{0,4} ([46] [3]) nl?
cD 					<-	[dD] / BACKSLASH [0]{0,4} ([46] [4]) nl?
cE 					<-	[eE] / BACKSLASH [0]{0,4} ([46] [5]) nl?
cF 					<-	[fF] / BACKSLASH [0]{0,4} ([46] [6]) nl?
cG 					<-	[gG] / BACKSLASH [0]{0,4} ([46] [7]) nl?
cH 					<-	[hH] / BACKSLASH [0]{0,4} ([46] [8]) nl?
cI 					<-	[iI] / BACKSLASH [0]{0,4} ([46] [9]) nl?
cJ 					<-	[jJ] / BACKSLASH [0]{0,4} ([46] [aA]) nl?
cK 					<-	[kK] / BACKSLASH [0]{0,4} ([46] [bB]) nl?
cL 					<-	[lL] / BACKSLASH [0]{0,4} ([46] [cC]) nl?
cM 					<-	[mM] / BACKSLASH [0]{0,4} ([46] [dD]) nl?
cN 					<-	[nN] / BACKSLASH [0]{0,4} ([46] [eE]) nl?
cO 					<-	[oO] / BACKSLASH [0]{0,4} ([46] [fF]) nl?
cP 					<-	[pP] / BACKSLASH [0]{0,4} ([57] [0]) nl?
cQ 					<-	[qQ] / BACKSLASH [0]{0,4} ([57] [1]) nl?
cR 					<-	[rR] / BACKSLASH [0]{0,4} ([57] [2]) nl?
cS 					<-	[sS] / BACKSLASH [0]{0,4} ([57] [3]) nl?
cT 					<-	[tT] / BACKSLASH [0]{0,4} ([57] [4]) nl?
cU 					<-	[uU] / BACKSLASH [0]{0,4} ([57] [5]) nl?
cV 					<-	[vV] / BACKSLASH [0]{0,4} ([57] [6]) nl?
cW 					<-	[wW] / BACKSLASH [0]{0,4} ([57] [7]) nl?
cX 					<-	[xX] / BACKSLASH [0]{0,4} ([57] [8]) nl?
cY 					<-	[yY] / BACKSLASH [0]{0,4} ([57] [9]) nl?
cZ 					<-	[zZ] / BACKSLASH [0]{0,4} ([57] [aA]) nl?


AT 					<-	"@"
ASTERISK 			<-	"*"
BACKSLASH 		<-	"\\"
CLOSE 				<-	")"
CLOSECURLY 		<-	"}"
CLOSESQUARE 		<-	"]"
COLON 				<-	":"
COMMA 			<-	","
DASH 				<-	"-"
DECIMALDIGIT 		<-	[0-9]
DOT 				<-	"."
DOUBLEQUOTE 		<-	"\""
EMPTY 				<-	""
EQUAL 				<-	"="
EXCLAMATION 		<-	"!"
FORWARDSLASH 	<-	"/"
GREATER 			<-	">"
HASHCHAR 		<-	"#"
MINUS 				<-	"-"
PERCENTSIGN 		<-	"%"
PLUS 				<-	"+"
OPEN 				<-	"("
OPENCURLY 		<-	"{"
OPENSQUARE 		<-	"["
s 					<-	WS+
SEMICOLON 		<-	";"
SINGLEQUOTE 		<-	"''"
UNDERSCORE 		<-	"_"
w 					<-	s?
WS 				<-	[ \t\r\n\x00000C]
/* End of file */'