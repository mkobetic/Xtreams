public
parse: aReadable base: anInteger ifFail: aBlock
	in := aReadable reading.
	base := anInteger.
	failBlock := [^ aBlock value].
	^ self parse