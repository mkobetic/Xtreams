tests - enumeration
testDetect

	| data result |
	data := ByteArray withAll: (1 to: 15).
	self output write: data; close.
	result := self input detect: [ :e | e \\ 4 = 0 ].
	self assert: result = 4.
	result := self input detect: [ :e | e \\ 4 = 0 ].
	self assert: result = 8.
	result := self input detect: [ :e | e \\ 4 = 0 ].
	self assert: result = 12.
	result := self input detect: [ :e | e \\ 4 = 0 ] ifNone: [ nil ].
	self assert: result = nil