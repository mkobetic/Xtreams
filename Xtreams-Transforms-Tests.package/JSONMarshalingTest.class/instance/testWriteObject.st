"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteObject

	| stream result |
	stream := String new writing marshaling: JSON.
	stream put: ((Dictionary new)
				at: 'one' put: 1;
				at: 'two' put: 2;
				yourself).
	result := stream
				close;
				terminal.
	self assert: result = '{"one": 1, "two": 2}'.

	"Nested Dictionary:"
	self
		assert: (JSON encode: (Dictionary with: 'a' -> (Dictionary with: 'b' -> nil)))
					= '{"a": {"b": null}}'