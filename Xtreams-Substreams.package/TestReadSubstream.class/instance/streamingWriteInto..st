"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream
	| object count |
	substreamAtEnd ifTrue: [^0].
	count := 0.
	^[      [       substreamAtEnd
		] whileFalse: [
			object := source get.
			(substreamAtEnd := test value: object)
				ifTrue: [inclusive ifTrue: [aWriteStream put: object. count := count + 1]]
				ifFalse:        [aWriteStream put: object. count := count + 1]].
		count
	] on: Incomplete do: [sourceAtEnd := substreamAtEnd := true. count ]
