"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteUnicodeString

	| stream result text |
	text := 'Příliš žluťoučký kůň úpěl ďábelské ódy'.
	stream := String new writing marshaling: JSON.
	stream put: text.
	result := stream close; terminal.
	self assert: result = ('"', text, '"')