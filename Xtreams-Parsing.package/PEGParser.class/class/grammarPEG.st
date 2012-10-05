grammars
grammarPEG
^'Grammar			<-	Definition+ !.
Definition			<-	s Identifier s (ASSIGN / DefinitionError) s Expression s
DefinitionError		<-	(!S .)*
Expression			<-	Sequence ((SLASH s Sequence) / (SequenceError s))*
Sequence			<-	Node+
SequenceError		<-	SLASH
Node				<-	Prefix? Primary Suffix? s
					/	!SLASH !(Identifier s ASSIGN) !CLOSE_PAREN !CLOSE_BRACE NodeError s
NodeError			<-	.
Primary				<-	Reference / Group / Literal / Range / DOT
Reference			<-	Identifier s !ASSIGN
Group				<-	OPEN_PAREN s Expression s CLOSE_PAREN
Prefix				<-	AND / NOT
Suffix				<-	Cardinality / QUESTION / STAR / PLUS

Literal				<-	QUOTE LiteralEntity{QUOTE}
					/	DOUBLE_QUOTE LiteralEntity{DOUBLE_QUOTE}
LiteralEntity			<-	Escape / .

Range				<-	OPEN_BRACKET s "^"? RangeSet{1,CLOSE_BRACKET}
RangeSet			<-	s LiteralEntity DASH LiteralEntity s
					/	s LiteralEntity s
Cardinality			<-	OPEN_BRACE s (CardinalityRange / CardinalityLoopMin / CardinalityRangeMin / CardinalityLoop) s CLOSE_BRACE
CardinalityRangeMin	<-	NumLiteral
CardinalityRange	<-	NumLiteral s COMMA s NumLiteral
CardinalityLoopMin	<-	NumLiteral s COMMA s Expression
CardinalityLoop		<-	Expression

Identifier				<-	[a-zA-Z_] [a-zA-Z0-9_]*
NumLiteral			<-	"Infinity" / "0" / [1-9] [0-9]*
Escape				<-	BACKSLASH [x] [0-9A-F]{6}
					/	BACKSLASH [nrts\-\\\[\]\''\"]
					/	EscapeError
EscapeError			<-	BACKSLASH .

s					<-	S*
S					<-	whitespace+
					/	comment
comment			<-	OPEN_COMMENT comment_body{CLOSE_COMMENT}
comment_body		<-	comment
					/	.
whitespace			<-	[\s\t\n\r]

ASSIGN				<-	"<-"
SLASH				<-	"/"
BACKSLASH		<-	"\\"
AND				<-	"&"
NOT				<-	"!"
COMMA				<-	","
QUESTION			<-	"?"
STAR				<-	"*"
PLUS				<-	"+"
DASH				<-	"-"
DOT				<-	"."
QUOTE				<-	"''"
DOUBLE_QUOTE	<-	''"''
OPEN_BRACKET	<-	"["
CLOSE_BRACKET	<-	"]"
OPEN_PAREN		<-	"("
CLOSE_PAREN		<-	")"
OPEN_BRACE		<-	"{"
CLOSE_BRACE		<-	"}"
OPEN_COMMENT	<-	"/*"
CLOSE_COMMENT	<-	"*/"
'