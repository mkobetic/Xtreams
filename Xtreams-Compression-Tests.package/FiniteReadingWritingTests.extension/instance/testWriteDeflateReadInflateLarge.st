"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - compression
"
testWriteDeflateReadInflateLarge

	| content result |
	content := ByteArray new: 32769.
	1 to: content size do: [:index | content at: index put: index \\ 256].
	self output compressing write: content; close.
	result := self input compressing read: content size.
	self assert: content = result.