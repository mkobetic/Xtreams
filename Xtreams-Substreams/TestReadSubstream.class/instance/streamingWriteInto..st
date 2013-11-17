"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
