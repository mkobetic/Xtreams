grammars
grammarSmalltalk
^'/* Lexical Primitives */
Token 					<- Number / Keyword / BinarySelector / Identifier / BlockArgument / AssignmentOperator / CharacterConstant / String / SpecialCharacter
Digit					<- [0-9] 
Letter					<- [A-Za-z] 
BinaryCharacter			<-[+/\\*~<>=@%|&?!,]
WhitespaceCharacter 	<- [\t\s\n\r]
EndOfMethod 			<- WhitespaceCharacter* !.
BACKQUOTE 			<- "`"
CLOSE 					<- ")"
CLOSECURLY			<- "}"
CLOSEPRAGMA 		<- ">"
CLOSESQUARE			<- "]"
COLON					<- ":"
DASH 					<- "-"
DOUBLEQUOTE 			<- "\""
EQUALS 				<- "="
FALSELITERAL			<- "false"
HASH 					<- "#"
NILLITERAL				<- "nil"
OPEN 					<- "("
OPENCURLY			<- "{"
OPENPRAGMA 			<- "<"
OPENSQUARE			<- "["
PERIOD 				<- "."
RETURN 				<- "^"
SELF 					<- "self"
SEMICOLON 			<- ";"
SINGLEQUOTE 			<- "''"
SUPER 					<- "super"
THISCONTEXT			<- "thisContext"
TRUELITERAL 			<- "true"
UNDERSCORE 			<- "_"
VERTICALBAR 			<- "|"
NonQuoteCharacter		<- Digit / Letter / BinaryCharacter / WhitespaceCharacter / BACKQUOTE / UNDERSCORE / OPEN / CLOSE / OPENSQUARE / CLOSESQUARE / OPENCURLY / CLOSECURLY / RETURN / COLON / SEMICOLON / PERIOD / DASH / HASH
Digits 					<- Digit+
BigDigits 				<- (Digit / Letter)+
Number 					<- Digits ("r" DASH? BigDigits / OptionalFractionAndExponent)
NotANumber 			<- !(&Number) Token
OptionalFractionAndExponent <- (PERIOD Digits)? ([eds] DASH? Digits)?
ExtendedLetter 			<- Letter / UNDERSCORE
Identifier 				<- ExtendedLetter (ExtendedLetter / Digit)*
BlockArgument 			<- Separator? COLON Separator? Identifier / BlockArgumentError
BlockArgumentError 		<- Separator? (COLON / Identifier) Separator? (COLON / &VERTICALBAR / &CLOSESQUARE / EndOfMethod / !Identifier)
AssignmentOperator 		<- ":="
Keyword 				<- Identifier COLON
BinarySelector 			<- (DASH / BinaryCharacter) (DASH / BinaryCharacter)?
UnarySelector 			<- Identifier !COLON
CharacterConstant 		<- "$" (NonQuoteCharacter / DOUBLEQUOTE / SINGLEQUOTE)
Symbol 					<- Identifier / BinarySelector / Keyword+
String 					<- SINGLEQUOTE ((NonQuoteCharacter / SINGLEQUOTE SINGLEQUOTE / DOUBLEQUOTE)* SINGLEQUOTE) / StringError
StringError 				<- SINGLEQUOTE (NonQuoteCharacter / SINGLEQUOTE SINGLEQUOTE / DOUBLEQUOTE)* !SINGLEQUOTE
						/ SINGLEQUOTE NonQuoteCharacter+ SINGLEQUOTE !(&Separator) NonQuoteCharacter+ SINGLEQUOTE
Comment 				<- DOUBLEQUOTE (NonQuoteCharacter / SINGLEQUOTE)* DOUBLEQUOTE / UnterminatedCommentError
UnterminatedCommentError 	<- DOUBLEQUOTE (NonQuoteCharacter / SINGLEQUOTE)* !DOUBLEQUOTE
Separator 				<- (WhitespaceCharacter / Comment)+
SpecialCharacter 		<- [#$@\[\\\]{|}~] / [\x0000A1-\x0000A7\x0000A9-\x0000AE\x0000B0-\x0000B3\x0000B5-\x0000B7\x0000B9-\x0000BF]
						/ [\x0000C6\x0000D0\x0000D7\x0000D8\x0000DE\x0000DF\x0000E6\x0000F0\x0000F7\x0000F8\x0000FE]
						/ [\x000110\x000111\x000126\x000127\x000131-\x000133\x000138\x00013F\x000140-\x000142\x000149-\x00014B]
						/ [\x000152\x000153\x000166\x000167\x002018\x002019\x00201C\x00201D\x0020AC\x002122\x002126\x00215B]
						/ [\x00215B-\x00215E\x002190-\x002193\x00266A\x00FC10]
/* Atomic Terms */
Literal 					<- DASH? Number / NamedLiteral / SymbolLiteral / CharacterConstant / String / ArrayLiteral / ByteArrayLiteral / BindingLiteral
NamedLiteral 			<- NILLITERAL / TRUELITERAL / FALSELITERAL
SymbolLiteral 			<- HASH (Symbol / String) / SymbolError
SymbolError 				<- HASH !(&(OPEN / OPENSQUARE)) !(Symbol / String)
ArrayLiteral 				<- HASH ArrayLiteralBody
ArrayLiteralBody 			<- OPEN Separator? ArrayLiteralElement? (Separator ArrayLiteralElement)* Separator? CLOSE
ArrayLiteralElement		<- (Literal / Symbol / ArrayLiteralBody / ByteArrayLiteralBody)
ByteArrayLiteral 			<- HASH ByteArrayLiteralBody / ByteArrayError
ByteArrayLiteralBody 		<- OPENSQUARE ByteArrayNumbers CLOSESQUARE
ByteArrayNumbers 		<- Separator? Number? (Separator Number)* Separator?
ByteArrayError 			<- HASH OPENSQUARE (Separator? (Number Separator)* NotANumber (Separator Number)* Separator? CLOSESQUARE / ByteArrayNumbers !CLOSESQUARE)
BindingLiteral 			<- ExtendedBindingName / BindingReference
BindingName 			<- BindingNameError / !(NamedLiteral / PseudoVariableName / SUPER) Identifier
BindingNameError 		<- Identifier SINGLEQUOTE
ExtendedBindingName 	<- BindingName (PERIOD BindingName)* / ExtendedBindingError
ExtendedBindingError 	<- ((PERIOD BindingName)+ / (BindingName PERIOD)+ / PERIOD) (Separator / &CLOSECURLY)
BindingReference 		<- HASH OPENCURLY Separator? ExtendedBindingName Separator? CLOSECURLY
/* Expressions and Statements */
Primary 					<- ExtendedBindingName / BindingReference / PseudoVariableName / Literal / BlockConstructor / OPEN Expression CLOSE
PseudoVariableName 	<- SELF / THISCONTEXT
UnaryMessage 			<- Separator? UnarySelector
BinaryMessage 			<- Separator? BinarySelector Separator? BinaryMessageArgument
BinaryMessageArgument 	<- Primary (Separator UnaryMessage)*
KeywordMessage 		<- (Separator? Keyword Separator? KeywordMessageArgument / InvalidKeywordMessageError)+
KeywordMessageArgument 	<- Primary (Separator UnaryMessage)* Separator? BinaryMessage*
InvalidKeywordMessageError 	<- Keyword Separator? !(&KeywordMessageArgument)
CascadedMessages 		<- (Separator? CascadedMessage)*
CascadedMessage 		<- CascadeError / SEMICOLON (KeywordMessage / BinaryMessage / UnaryMessage )
CascadeError 			<- SEMICOLON !(&(KeywordMessage / BinaryMessage / UnaryMessage))
Messages 				<- Separator? (UnaryMessage+ BinaryMessage* KeywordMessage? / BinaryMessage+ KeywordMessage? / KeywordMessage)
RestOfExpression 		<- (Messages CascadedMessages)?
Expression 				<- (SUPER Messages CascadedMessages / SuperError)
						/ (ExtendedBindingName / BindingReference) Separator? (AssignmentOperator Separator? Expression / RestOfExpression)
 						/ Keyword EQUALS Expression
						/ Primary RestOfExpression
						/ ExpressionError
ExpressionError 			<- Separator? AssignmentOperator PERIOD?
SuperError 				<- SUPER Separator? !Messages
ExpressionList 			<- Expression (PERIOD Expression)* PERIOD?
Temporaries 			<- Separator? (VERTICALBAR TemporaryList? VERTICALBAR / TemporariesError)
TemporariesError 		<- VERTICALBAR TemporaryList? !VERTICALBAR
TemporaryList 			<-Separator? Identifier (Separator Identifier)* Separator?
DeclaredVariableName 	<- BindingName
Statements 				<- Separator? (ReturnStatement / Expression Separator? (PERIOD Statements)? )?
ReturnStatement 			<- RETURN Separator? Expression (PERIOD (Separator? StatementError)?)? / ReturnError
ReturnError 				<- RETURN Separator? (CLOSESQUARE / CLOSE / EndOfMethod)
StatementError 			<- (!(&CLOSESQUARE) Token)+ CLOSESQUARE
						/ (!(&CLOSE) Token)+ CLOSE
						/ Token+ EndOfMethod
BlockConstructor 		<- OPENSQUARE Separator? BlockDeclarations? Statements Separator? CLOSESQUARE / UnterminatedBlockError
UnterminatedBlockError 	<- OPENSQUARE Separator? BlockDeclarations? Separator? (&PERIOD / Statements) Separator? !(&CLOSESQUARE)
BlockDeclarations 		<- Temporaries
 						/ BlockArgument+ Separator? VERTICALBAR Temporaries?
BlockDeclarationError 	<- (COLON Separator?)* BlockArgument? (COLON Separator?)* &VERTICALBAR?
/* Methods */
Method 					<- Separator? MessagePattern MethodBody Separator? (EndOfMethod / MethodError)
MethodBody				<- Pragmas? Temporaries? Statements?
						/ Temporaries? Pragmas? Statements?
MethodError 				<- .* !.
MessagePattern 			<- KeywordPattern / BinaryPattern / UnarySelector
BinaryPattern 			<- BinarySelector Separator MessageArgument / BinaryPatternError
BinaryPatternError 		<- BinarySelector !(Separator MessageArgument)
KeywordPattern 			<- KeywordWithArgument (Separator KeywordWithArgument)* / KeywordPatternError
KeywordWithArgument 	<- KeywordPatternError / Keyword Separator? MessageArgument
KeywordPatternError 		<- Keyword Separator? Keyword / Keyword !(Separator? MessageArgument)
MessageArgument 		<- Identifier
Pragma 					<- OPENPRAGMA PragmaBody CLOSEPRAGMA / PragmaError
PragmaKeyword 			<- Keyword Separator? Literal
PragmaBody 			<- Separator? ((PragmaKeyword (Separator PragmaKeyword)*) / UnarySelector) Separator?
PragmaError 			<- OPENPRAGMA (
							EndOfMethod
							/ Separator? (PragmaKeyword Separator)* (Keyword Separator?)+ Separator? (PragmaKeyword Separator)* Separator? CLOSEPRAGMA?
							/ PragmaBody !CLOSEPRAGMA
							/ Separator? Token (Separator? !(&CLOSEPRAGMA) Token)* Separator? (CLOSEPRAGMA / EndOfMethod)
						)
Pragmas 				<- Separator? Pragma (Separator? Pragma)*'