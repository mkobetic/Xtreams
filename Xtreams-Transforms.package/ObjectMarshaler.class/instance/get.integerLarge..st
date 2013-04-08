"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - numbers
"
get: reading integerLarge: integer
	| printed |
	printed := self get: reading string: String.
	^Number readIntegerFrom: printed readStream radix: 36