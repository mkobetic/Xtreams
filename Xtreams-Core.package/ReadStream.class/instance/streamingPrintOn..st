"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: printing
"
streamingPrintOn: aStream
	| hash |
	aStream write: self class name; put: $..
	hash := self identityHash bitAnd: 16rFFF.
	[ hash > 0 ] whileTrue: [
		aStream put: ('ABCDEFGHIJKLMNOP' at: (hash bitAnd: 15) + 1).
		hash := hash bitShift: -4 ]