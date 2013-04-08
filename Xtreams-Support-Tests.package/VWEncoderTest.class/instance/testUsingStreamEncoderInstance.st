"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testUsingStreamEncoderInstance

	| encoder vwEncoder |
	vwEncoder := StreamEncoder new: 'ms-cp-1252'.
	encoder := Encoder for: vwEncoder.
	self assert: (encoder isKindOf: VWEncoder).
	self assert: encoder encoder == vwEncoder