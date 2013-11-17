"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
