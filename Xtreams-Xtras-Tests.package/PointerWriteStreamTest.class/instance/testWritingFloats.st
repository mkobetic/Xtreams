"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
testWritingFloats

	| values |
	self prepareFloats.
	stream put: Float pi.
	self assert: (stream terminal at: 0) = Float pi.
	values := (1 to: 10) collect: [ :i | i reciprocal asFloat ].
	stream write: values.
	self assert: (stream terminal at: 10) = 10 reciprocal asFloat.
	stream close.
	self assert: stream length = 11.