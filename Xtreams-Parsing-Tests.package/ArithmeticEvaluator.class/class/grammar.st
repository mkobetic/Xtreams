"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
grammar
	^'
	Number <- [0-9]+
	Parenthesised <- "(" Expr ")"
	Value <- Number / Parenthesised
	Product	<- Value (("*" / "/") Value)*
	Sum <- Product (("+" / "-") Product)*
	Expr <- Sum
	'