"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testWriteCollectingIncompatibleContentSpecies
	| data |
	data := (1 to: 15) collect: [ :x | x @ 0 ].
	(self output collecting: [:e | e x ]) write: data.
	self assert: (self input read: data size) = (ByteArray withAll: (data collect: [:e | e x]))
