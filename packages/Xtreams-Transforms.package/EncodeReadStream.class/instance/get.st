accessing
get
	| character |
	buffer hasDataToRead ifTrue: [^super get].
	character := encoder decodeFrom: source.
	transparent ifFalse: 
		[character == LF
			ifTrue: [crPreceeding
				ifTrue: 
					[character := encoder decodeFrom: source.
					crPreceeding := character = CR]
				ifFalse: 
					[crPreceeding := false.
					character := CR]]
			ifFalse: [crPreceeding := character = CR]].
	^character