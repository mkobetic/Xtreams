"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: api
"
unmarshal: reading
	| type |
	type := reading uint8 get.
	type <= 16rBF ifTrue: [
		| fixMapOrArray |
		type <= 16r7F ifTrue: [^type].
		fixMapOrArray := type bitShift: -4.
		fixMapOrArray = 2r1001 ifTrue: [^(1 to: (type bitAnd: 2r00001111)) collect: [:i | self unmarshal: reading]].
		fixMapOrArray = 2r1000 ifTrue: [
			| map |
			map := Dictionary new.
			(type bitAnd: 2r00001111) timesRepeat: [
				map at: (self unmarshal: reading) put: (self unmarshal: reading)].
			^map].
		^reading uint8 read: (type bitAnd: 2r00011111)].
	(type bitShift: -5) = 2r111 ifTrue: [^-32 + (type bitAnd: 2r00011111)].
	^(unmarshaling at: type) value: reading
