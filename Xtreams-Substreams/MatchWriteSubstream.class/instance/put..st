"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
put: anObject
	substreamAtEnd ifTrue: [Incomplete zero raise].
	[self gobble: anObject] on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. incomplete pass].
	^anObject
