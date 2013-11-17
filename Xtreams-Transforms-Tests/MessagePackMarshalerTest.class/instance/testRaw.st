"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testRaw
	| big |
	big := ByteArray new: 100000 withAll: 1.
	marshaling put: #[10 255 0].
	marshaling put: (ByteArray withAll: (1 to: 255)).
	marshaling put: big.
	self analyse.
	self assert: marshaling get = #[10 255 0].
	self assert: marshaling get = (ByteArray withAll: (1 to: 255)).
	self assert: marshaling get = big
