*Xtreams-TransformsTests-tests-transforming
testWriteTransformingOverLimitingPastEnd

	| limited transferred |
	limited := (self output limiting: 10) transforming: [ :in :out | out put: in get ].
	self assert: (
		[	limited write: (ByteArray withAll: (1 to: 20)).
			false
		] on: Incomplete do: [ :ex | ex count = 11 ] ).
	transferred := self input read: 10.
	self assert: transferred = (ByteArray withAll: (1 to: 10))