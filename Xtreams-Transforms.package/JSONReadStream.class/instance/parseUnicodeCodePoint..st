"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseUnicodeCodePoint: digits

	| hex codePoint |
	hex := '0123456789abcdef'.
	codePoint := digits inject: 0 into: [ :nr :c | nr * 16 + (hex indexOf: c) - 1 ].
	^codePoint asCharacter