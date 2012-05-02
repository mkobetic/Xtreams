*Xtreams-TransformsTests-transforming
testWriteCollectingIncompatibleContentSpecies
	| data |
	data := (1 to: 15) collect: [ :x | x @ 0 ].
	(self output collecting: [:e | e x ]) write: data.
	self assert: (self input read: data size) = (ByteArray withAll: (data collect: [:e | e x]))