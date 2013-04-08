"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteCollections
	"Test collections objects here."
	<test>

	self assert: (JSON encode: Array new) = '[]'.
	self assert: (JSON encode: #(0 1 'x' #y)) = '[0, 1, "x", "y"]'.
	self
		assert: (JSON encode:  (OrderedCollection
				with: 0
				with: 1
				with: 'x'
				with: #y))
				= '[0, 1, "x", "y"]'