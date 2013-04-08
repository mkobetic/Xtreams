"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteRepeatingPattern

	| output stream result count |
	stream := (output := String new writing) ending: '--'.
	count := [ stream write: '123-45--6789'  ] on: Incomplete do: [ :ex | ex count ].
	self assert: count = 6.
	result := output conclusion.
	self assert: result = '123-45'