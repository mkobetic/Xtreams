"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWritePrimitiveTypes
	"Test the primitive types for JSON encoding."
	"Undefined object"
	<test>

	self assert: (JSON encode: nil) = 'null'.

	"Just an object"
	self assert: (JSON encode: Object new) = '{}'.

	" Numbers: "
	self assert: (JSON encode: 0) = '0'.
	self assert: (JSON encode: 0.0) = '0.0'.
	self assert: (JSON encode: Float.Pi) = Float.Pi printString.

	" Booleans: "
	self assert: (JSON encode: true) = 'true'.
	self assert: (JSON encode: false) = 'false'.

	"Some characters:"
	self assert: (JSON encode: Character space) = '" "'.
	self assert: (JSON encode: Character tab) = '"\t"'.
	self assert: (JSON encode: Character cr) = '"\n"'.
	self assert: (JSON encode: Character lf) = '"\r"'.
	self assert: (JSON encode: (Character value: 0)) = '"\u0000"'.

	"Strings:"
	self assert: (JSON encode: '') = '""'.
	self assert: (JSON encode: 'some string') = '"some string"'