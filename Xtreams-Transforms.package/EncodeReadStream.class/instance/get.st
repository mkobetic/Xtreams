"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
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