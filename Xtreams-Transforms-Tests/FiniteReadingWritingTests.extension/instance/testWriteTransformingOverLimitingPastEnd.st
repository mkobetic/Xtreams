"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testWriteTransformingOverLimitingPastEnd

	| limited transferred |
	limited := (self output limiting: 10) transforming: [ :in :out | out put: in get ].
	self assert: (
		[       limited write: (ByteArray withAll: (1 to: 20)).
			false
		] on: Incomplete do: [ :ex | ex count = 11 ] ).
	transferred := self input read: 10.
	self assert: transferred = (ByteArray withAll: (1 to: 10))
