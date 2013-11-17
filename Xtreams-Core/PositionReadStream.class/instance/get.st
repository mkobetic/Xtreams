"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
get
	| object |
	buffer hasDataToRead ifTrue: [^buffer get].
	object := source get.
	buffer put: object.
	buffer readSkip: 1.
	^object
