accessing
input

	^input ifNil: [ input := (self output close; terminal) reading ]