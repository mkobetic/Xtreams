"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
next: count

	|bytes|

	bytes := ByteArray new: count.
	character isNil
		ifTrue: [ stream read: count into: bytes ]
		ifFalse: [ bytes at: 1 put: character.
			character := nil.
			stream read: count - 1 into: bytes at: 2 ].
	^bytes
