grammars
grammarJavascript
^'/* Lexical Grammar */
/* SourceCharacter 			<- . */
/* WhiteSpace 					<- TAB / VT / FF/ SPACE / NBSP / USP */
WhiteSpace 					<- [\s\t\x00000B\x00000C]
/* LineTerminator 				<- LF / CR / LS / PS */
LineTerminator 				<- LF / CR
Comment 					<- MultiLineComment 
							/ SingleLineComment
MultiLineComment 			<- [/] [*] MultiLineCommentChars? [*] [/] 
MultiLineCommentChars 		<- MultiLineNotAsteriskChar+ 
							/ ASTERISK PostAsteriskCommentChars?
PostAsteriskCommentChars 	<- MultiLineNotForwardSlashOrAsteriskChar MultiLineCommentChars? 
							/ ASTERISK PostAsteriskCommentChars?
MultiLineNotAsteriskChar 		<- !ASTERISK
MultiLineNotForwardSlashOrAsteriskChar 	<- !(FORWARDSLASH / ASTERISK)
SingleLineComment 			<- "//" .{[\x00000A\x00000D]}
ReservedWord 				<- BooleanLiteral
							/ NullLiteral
							/ Keyword
Keyword 					<- RETURN / BREAK / CASE / CATCH / CONTINUE / DEFAULT / DELETE / DO
							/ ELSE / FINALLY / FOR / FUNCTION / IF / IN / INSTANCEOF
							/ NEW / SWITCH / THIS / THROW / TRY / TYPEOF
							/ VAR / VOID / WHILE / WITH
Identifier 					<- !(ReservedWord (WhiteSpace / Punctuator)) IdentifierName
IdentifierName 				<- IdentifierStart IdentifierPart*
IdentifierStart 				<- [A-Za-z$_]
							/ BACKSLASH UnicodeEscapeSequence
IdentifierPart 				<- IdentifierStart
							/ DecimalDigit
HexDigit 					<- [0123456789abcdefABCDEF]
Punctuator 					<- "{" / "}" / "(" / ")" / "[" / "]" / "." / SEMICOLON / "," / "<" / ">" / "<=" / ">="
							/ "==" / "!=" / "===" / "!==" / "+" / "-" / "*" / PERCENT / "++" / "--" / "<<" / ">>"
							/ ">>>" / AMP / VERTICALBAR / "^" / EXCLAMATION / TILDE / (AMP AMP) / "||" / QUESTION / COLON / EQUAL
							/ "+=" / "-=" / "*=" / "%=" / "<<=" / ">>=" / ">>>=" / "&=" / "|=" / "^="
DivPunctuator 				<- "/" / "/="
Literal 						<- NullLiteral
							/ BooleanLiteral
							/ StringLiteral
							/ NumericLiteral
NullLiteral 					<- "null"
BooleanLiteral 				<- "true" / "false"
NumericLiteral 				<- DecimalLiteral
							/ HexIntegerLiteral
DecimalLiteral 				<- DecimalIntegerLiteral (DOT DecimalDigits?)? ExponentPart?
							/ DOT DecimalDigits ExponentPart?
							/ DecimalIntegerLiteral ExponentPart?
DecimalIntegerLiteral 		<- NonZeroDigit DecimalDigits?
							/ [0]
DecimalDigits 				<- [0123456789]*
NonZeroDigit 				<- [123456789]
DecimalDigit 				<- [0123456789]
ExponentPart 				<- ExponentIndicator SignedInteger
ExponentIndicator 			<- [eE]
SignedInteger 				<- (PLUS / MINUS)? DecimalDigits
HexIntegerLiteral 			<- [0] [xX] HexDigit+
StringLiteral 					<- DOUBLEQUOTE DoubleStringCharacters? DOUBLEQUOTE
							/ SINGLEQUOTE SingleStringCharacters? SINGLEQUOTE
DoubleStringCharacters 		<- DoubleStringCharacter+
SingleStringCharacters 		<- SingleStringCharacter+
DoubleStringCharacter 		<- !(&(DOUBLEQUOTE / BACKSLASH / LineTerminator)) .
							/ BACKSLASH EscapeSequence
SingleStringCharacter 		<- !(&(SINGLEQUOTE / BACKSLASH / LineTerminator)) .
							/ BACKSLASH EscapeSequence
EscapeSequence 			<- CharacterEscapeSequence
							/ HexEscapeSequence
							/ UnicodeEscapeSequence
							/ [0] &(!DecimalDigit)
CharacterEscapeSequence 	<- SingleEscapeCharacter
							/ NonEscapeCharacter
SingleEscapeCharacter 		<- [\''\"\\bfnrtv]
NonEscapeCharacter 		<- !(&(EscapeCharacter / LineTerminator)) .
EscapeCharacter 			<- SingleEscapeCharacter
							/ DecimalDigit
							/ [xu]
HexEscapeSequence 		<- [x] HexDigit HexDigit
UnicodeEscapeSequence 	<- [u] HexDigit HexDigit HexDigit HexDigit
RegularExpressionLiteral 		<- FORWARDSLASH RegularExpressionBody FORWARDSLASH RegularExpressionFlags
RegularExpressionBody 		<- RegularExpressionFirstChar RegularExpressionChars
RegularExpressionChars 		<- RegularExpressionChar*
RegularExpressionFirstChar 	<- BackslashSequence
							/ !(&(ASTERISK / BACKSLASH / FORWARDSLASH)) NonTerminator
RegularExpressionChar 		<- BackslashSequence
							/ !(&(BACKSLASH / FORWARDSLASH)) NonTerminator
BackslashSequence 			<- BACKSLASH NonTerminator
NonTerminator 				<- !(&LineTerminator) .
RegularExpressionFlags 		<- IdentifierPart*

/* Number Conversions */
StringNumericLiteral 			<- StrWhiteSpace? (StrNumericLiteral StrWhiteSpace?)?
StrWhiteSpace 				<- StrWhiteSpaceChar StrWhiteSpace?

/* This is according to EcmaScript grammar. NBSP, USP, LS & PS - what are their definitions?
StrWhiteSpaceChar 			<- TAB / SPACE / NBSP / FF / VT / CR / LF / LS / PS / USP */

StrWhiteSpaceChar 			<- TAB / SPACE  / FF / VT / CR / LF
StrNumericLiteral 			<- StrDecimalLiteral
							/ HexIntegerLiteral
StrDecimalLiteral 			<- (PLUS / MINUS)? StrUnsignedDecimalLiteral
StrUnsignedDecimalLiteral 	<- INFINITY
							/ DecimalDigits (DOT DecimalDigits)? ExponentPart?
							/ DOT DecimalDigits ExponentPart?
/* Expressions: */
PrimaryExpression 			<- ArrayLiteral
							/ ObjectLiteral
							/ OPEN Expression CLOSE
							/ THIS
							/ Literal
							/ Identifier
ArrayLiteral 					<- OPENSQUARE SS ElementList? (COMMA Elision)? SS CLOSESQUARE
ElementList 					<- Elision? SS AssignmentExpression (Elision? SS AssignmentExpression)*
Elision 						<- SS COMMA (SS COMMA)*
ObjectLiteral 				<- OPENCURLY SS PropertyNameAndValueList? CLOSECURLY / ObjectLiteralError
ObjectLiteralError			<- OPENCURLY .{CLOSECURLY}
PropertyNameAndValueList 	<- (PropertyName SS [:] SS PropertyValue SS)+
PropertyValue				<- AssignmentExpression (SS [,] SS PropertyNameAndValueList)?
PropertyName 				<- Identifier
							/ StringLiteral
							/ NumericLiteral
MemberExpression 			<- (PrimaryExpression / FunctionExpression) (OPENSQUARE SS Expression SS CLOSESQUARE / DOT Identifier)*
							/ NEW SS MemberExpression SS Arguments
NewExpression 				<- MemberExpression
							/ NEW SS NewExpression
CallExpression 				<- MemberExpression SS Arguments (
								(SS Arguments
								/ OPENSQUARE SS Expression SS CLOSESQUARE
								/ DOT Identifier) )*
Arguments 					<- OPEN SS (ArgumentList SS)? CLOSE
ArgumentList 				<- AssignmentExpression (SS COMMA SS AssignmentExpression)*
LeftHandSideExpression 		<- CallExpression
							/ NewExpression
PostfixExpression 			<- LeftHandSideExpression (WSNT ("++" / "--"))?
UnaryExpression 			<- PostfixExpression
							/ ( DELETE / VOID / TYPEOF / "++" / "--" / PLUS / MINUS / TILDE / EXCLAMATION ) SS UnaryExpression
MultiplicativeExpression 		<- UnaryExpression (SS (ASTERISK / FORWARDSLASH / PERCENT) SS UnaryExpression)*
AdditiveExpression 			<- MultiplicativeExpression (SS (PLUS / MINUS) SS MultiplicativeExpression)*
ShiftExpression 				<- AdditiveExpression (SS ("<<" / ">>>" / ">>" ) SS AdditiveExpression)*
RelationalExpression 		<- ShiftExpression (SS ("<=" / ">=" / "<" / ">" / INSTANCEOF / IN) SS ShiftExpression)*
RelationalExpressionNoIn 	<- ShiftExpression (SS ("<=" / ">=" / "<" / ">" / INSTANCEOF ) SS ShiftExpression)*
EqualityExpression 			<- RelationalExpression (SS ("===" / "!===" / "==" / "!=" ) SS RelationalExpression)*
EqualityExpressionNoIn 		<- RelationalExpressionNoIn (SS ( "===" / "!===" / "==" / "!=" ) SS RelationalExpressionNoIn)*
BitwiseANDExpression 		<- EqualityExpression (SS AMP SS EqualityExpression)*
BitwiseANDExpressionNoIn 	<- EqualityExpressionNoIn (SS AMP SS EqualityExpressionNoIn)*
BitwiseXORExpression 		<- BitwiseANDExpression (SS "^" SS BitwiseANDExpression)*
BitwiseXORExpressionNoIn 	<- BitwiseANDExpressionNoIn (SS "^" SS BitwiseANDExpressionNoIn)*
BitwiseORExpression 		<- BitwiseXORExpression (SS VERTICALBAR SS BitwiseXORExpression)*
BitwiseORExpressionNoIn 	<- BitwiseXORExpressionNoIn (SS VERTICALBAR SS BitwiseXORExpressionNoIn)*
LogicalANDExpression 		<- BitwiseORExpression (SS "&&" SS BitwiseORExpression)*
LogicalANDExpressionNoIn 	<- BitwiseORExpressionNoIn (SS "&&" SS BitwiseORExpressionNoIn)*
LogicalORExpression 		<- LogicalANDExpression (SS "||" SS LogicalANDExpression)*
LogicalORExpressionNoIn 	<- LogicalANDExpressionNoIn (LogicalORExpressionNoIn SS "||" SS LogicalANDExpressionNoIn)*
ConditionalExpression 		<- LogicalORExpression (SS QUESTION SS AssignmentExpression SS COLON SS AssignmentExpression)?
ConditionalExpressionNoIn 	<- LogicalORExpressionNoIn (SS QUESTION SS AssignmentExpressionNoIn SS COLON SS AssignmentExpressionNoIn)?
AssignmentExpression 		<- LeftHandSideExpression SS AssignmentOperator SS AssignmentExpression
							/ ConditionalExpression
AssignmentExpressionNoIn 	<- LeftHandSideExpression SS AssignmentOperator SS AssignmentExpressionNoIn
							/ ConditionalExpressionNoIn
AssignmentOperator 			<- EQUAL / "*=" / "/=" / "%=" / "+=" / "-=" / "<<=" / ">>=" / ">>>=" / "&=" / "^=" / "|="
Expression 					<- AssignmentExpression (SS COMMA SS AssignmentExpression)*
ExpressionNoIn 				<- AssignmentExpressionNoIn (SS COMMA SS AssignmentExpressionNoIn)*

/* Statements: */
Statement 					<- SS !(&CLOSECURLY) (Block
							/ VariableStatement
							/ EmptyStatement
							/ IfStatement
							/ IterationStatement
							/ ContinueStatement
							/ BreakStatement
							/ ReturnStatement
							/ WithStatement
							/ LabelledStatement
							/ SwitchStatement
							/ ThrowStatement
							/ ExpressionStatement
							/ TryStatement)
StatementOrError				<- Statement / NoStatementError
NoStatementError			<- .{EndOfSource / StartOfStatement}
Block 						<- OPENCURLY SS (StatementList SS)? CloseBlock
CloseBlock					<- CLOSECURLY / CloseBlockError
CloseBlockError				<- .{CLOSECURLY / EndOfSource}
StatementList 				<- Statement+
VariableStatement 			<- VAR SS VariableDeclarationList EndOfStatement
VariableDeclarationList 		<- VariableDeclaration (SS COMMA SS VariableDeclaration)*
VariableDeclarationListNoIn 	<- VariableDeclarationNoIn (SS COMMA SS VariableDeclarationNoIn)*
VariableDeclaration 			<- Identifier SS Initialiser?
VariableDeclarationNoIn 		<- Identifier SS InitialiserNoIn?
Initialiser 					<- EQUAL SS AssignmentExpression
InitialiserNoIn 				<- EQUAL SS AssignmentExpressionNoIn
EmptyStatement 				<- SEMICOLON SS
ExpressionStatement 			<- !(&(OPENCURLY / FUNCTION)) Expression EndOfStatement
IfStatement 					<- IF SS OPEN SS Expression SS CLOSE SS Statement (SS ELSE SS Statement)?
IterationStatement 			<- DoStatement / WhileStatement / ForStatement
ContinueStatement 			<- CONTINUE WSNT Identifier?
BreakStatement 				<- BREAK WSNT Identifier?
ReturnStatement 				<- RETURN WSNT Expression?
WithStatement 				<- WITH SS OPEN SS Expression SS CLOSE Statement
SwitchStatement 				<- SWITCH SS OPEN SS Expression SS CLOSE CaseBlock
CaseBlock 					<- OPENCURLY SS (CaseClauses SS)? (DefaultClause SS (CaseClauses SS)?)? CLOSECURLY
CaseClauses 				<- CaseClause (SS CaseClause)*
CaseClause 					<- CASE SS Expression SS COLON SS StatementList?
DefaultClause 				<- DEFAULT SS COLON SS StatementList?
LabelledStatement 			<- Identifier SS COLON SS Statement
ThrowStatement 				<- THROW WSNT Expression EndOfStatement
TryStatement 				<- TRY SS Block SS (Catch SS Finally / Catch / Finally)
Catch 						<- CATCH SS OPEN SS Identifier SS CLOSE SS Block
Finally 						<- FINALLY SS Block

/* Iteration statements */
DoStatement					<- DO StatementOrError WhileClause EndOfStatement
WhileStatement				<- WhileClause StatementOrError
ForStatement				<- ForClause StatementOrError
WhileClause					<- SS WHILE SS RestOfWhileClause
RestOfWhileClause			<- OPEN SS Expression SS CLOSE / WhileClauseError
WhileClauseError			<- OPEN SS CLOSE / .{BRACKET / EndOfSource}
ForClause					<- FOR SS RestOfForClause
RestOfForClause				<- OPEN SS ForConditions SS CLOSE / ForClauseError
ForClauseError				<- OPEN SS CLOSE / .{SEMICOLON / BRACKET / EndOfSource}
ForConditions				<- ForConditionsVAR / ForConditionsLeft / ForConditionsNoIn
ForConditionsVAR			<- VAR SS (
								VariableDeclarationNoIn SS IN Expression
								/ VariableDeclarationListNoIn SS SEMICOLON SS Expression? SS SEMICOLON SS Expression?)
ForConditionsLeft			<- LeftHandSideExpression SS IN SS Expression
ForConditionsNoIn			<- ExpressionNoIn? SS SEMICOLON SS Expression? SS SEMICOLON SS Expression?
								

/* Functions and Programs */
FunctionDeclaration 			<- SS FUNCTION WhiteSpace+ Identifier SS FunctionDefinition
FunctionExpression 			<- SS FUNCTION (WhiteSpace+ Identifier)? SS FunctionDefinition
FunctionDefinition 			<- SS OpenList SS FormalParameterList? SS CloseList SS OpenFunction SS FunctionBody SS CloseFunction
OpenFunction 				<- OPENCURLY / OpenFunctionError
OpenFunctionError 			<- .{OPENCURLY / EndOfSource}
OpenList 					<- OPEN / OpenListError
OpenListError 				<- .{OPEN / EndOfSource}
CloseFunction				<- CLOSECURLY / CloseFunctionError
CloseFunctionError			<- .{CLOSECURLY / EndOfSource}
CloseList 					<- CLOSE / CloseListError
CloseListError 				<- .{CLOSE / EndOfSource}
FormalParameterList 			<- Identifier (SS COMMA SS Identifier)*
FunctionBody 				<- SourceElements?
Program 					<- SourceElements SS EndOfSource / ProgramError
ProgramError 				<- .{EndOfSource}
SourceElements 				<- SourceElement+
SourceElement 				<- FunctionDeclaration / Statement


/* Universal Resource Identifier Character Classes */
uri 							<- uriCharacters?
uriCharacters 				<- uriCharacter+
uriCharacter 					<- uriReserved
							/ uriUnescaped
							/ uriEscaped
uriReserved 					<- SEMICOLON / FORWARDSLASH / QUESTION / COLON / AT / AMP / EQUAL / PLUS / DOLLAR / COMMA
uriUnescaped 				<- uriAlpha
							/ DecimalDigit
							/ uriMark
uriEscaped 					<- PERCENT HexDigit HexDigit
uriAlpha 					<- [a-zA-Z]
uriMark 						<- MINUS / UNDERSCORE / DOT / EXCLAMATION / TILDE / ASTERISK / SINGLEQUOTE / OPEN / CLOSE

/* Regular Expressions: */
Pattern 						<- Disjunction
Disjunction 					<- Alternative (SS VERTICALBAR SS Alternative)*
Alternative 					<- (SS Term)*
Term 						<- Assertion / Atom Quantifier?
Assertion 					<- "^" / DOLLAR / BACKSLASH [bB]
Quantifier 					<- QuantifierPrefix QUESTION?
QuantifierPrefix 				<- ASTERISK
							/ PLUS
							/ QUESTION
							/ OPENCURLY SS DecimalDigits (SS COMMA (SS DecimalDigits)?)? SS CLOSECURLY
Atom 						<- PatternCharacter
							/ DOT
							/ BACKSLASH AtomEscape
							/ CharacterClass
							/ OPEN (QUESTION (COLON / EQUAL / EXCLAMATION))? Disjunction CLOSE
PatternCharacter 			<- !(&[^$\\.*+?()\[\]{}|]) .
AtomEscape 				<- DecimalEscape
							/ CharacterEscape
							/ CharacterClassEscape
CharacterEscape 			<- ControlEscape
							/ "c" ControlLetter
							/ HexEscapeSequence
							/ UnicodeEscapeSequence
							/ IdentityEscape
ControlEscape 				<- [fnrtv]
ControlLetter 				<- [a-zA-Z]
IdentityEscape 				<- !(&IdentifierPart) .
DecimalEscape 				<- DecimalIntegerLiteral !(&DecimalDigit)
CharacterClassEscape 		<- [dDsSwW]
CharacterClass 				<- OPENSQUARE "^"? ClassRanges CLOSESQUARE
ClassRanges 				<- NonemptyClassRanges?
NonemptyClassRanges 		<- ClassAtom (NonemptyClassRangesNoDash / MINUS ClassAtom ClassRanges)
NonemptyClassRangesNoDash 	<- ClassAtom
							/ ClassAtomNoDash (NonemptyClassRangesNoDash / MINUS ClassAtom ClassRanges)
ClassAtom 					<- MINUS
							/ ClassAtomNoDash
ClassAtomNoDash 			<- !(&(BACKSLASH / CLOSESQUARE / MINUS)) .
							/ BACKSLASH ClassEscape
ClassEscape 				<- DecimalEscape
							/ [b]
							/ CharacterEscape
							/ CharacterClassEscape

/* The following are not part of the ECMAScript grammar. They are added for clarity and simplicity of the above grammar rule definitions. */
SS 							<- ([\s\t\x00000A\x00000B\x00000C\x00000D] / Comment)*
WSNT 						<- (!(&LineTerminator) (WhiteSpace / Comment))*
AMP 						<- "&" 
ASTERISK 					<- "*"
AT 							<- "@"
BACKSLASH 				<- "\\"
BREAK 						<- "break"
BRACKET					<- OPEN / OPENCURLY / OPENSQUARE / CLOSE / CLOSECURLY / CLOSESQUARE
CASE 						<- "case"
CATCH 						<- "catch"
CLOSE 						<- ")"
CLOSECURLY 				<- "}"
CLOSESQUARE 				<- "]"
COLON 						<- ":"
COMMA 					<- ","
CONTINUE 					<- "continue"
CR 							<- "\x00000D"
DEFAULT 					<- "default"
DELETE 					<- "delete"
DO 							<- "do"
DOLLAR 					<- "$"
DOT 						<- "."
DOUBLEQUOTE 				<- "\""
EndOfStatement 				<- SS (EndOfSource / !(&CLOSECURLY) SEMICOLON / &CLOSECURLY SEMICOLON? )
StartOfStatement				<- OPENCURLY / VAR / FOR / DO / WITH / SWITCH / THROW / TRY / BRACKET / WHILE / IF / CONTINUE / BREAK / RETURN
EndOfSource 				<- !.
ELSE 						<- "else"
EMPTY 						<- ""
EQUAL 						<- "="
EXCLAMATION 				<- "!"
FF 							<- [\x00000C]
FINALLY 					<- "finally"
FOR 						<- "for"
FORWARDSLASH 			<- "/"
FUNCTION 					<- "function"
IF 							<- "if"
IN 							<- "in"
INFINITY 					<- "Infinity"
INSTANCEOF 				<- "instanceof"
LF 							<- "\x00000A"
MINUS 						<- "-"
NEW 						<- "new"
OPEN 						<- "("
OPENCURLY 				<- "{"
OPENSQUARE 				<- "["
PERCENT 					<- "%"
PLUS 						<- "+"
QUESTION 					<- "?"
RETURN 					<- "return"
SEMICOLON 				<- ";"
SINGLEQUOTE 				<- "''"
SPACE 						<- " "
SWITCH 					<- "switch" 
TAB 						<- [\t]
THROW 					<- "throw"
THIS 						<- "this"
TILDE 						<- "~"
TRY 						<- "try"
TYPEOF 					<- "typeof"
UNDERSCORE 				<- "_"
VAR 						<- "var"
VERTICALBAR 				<- "|"
VOID 						<- "void"
VT 							<- "\x00000B"
WHILE 						<- "while"
WITH 						<- "with"'