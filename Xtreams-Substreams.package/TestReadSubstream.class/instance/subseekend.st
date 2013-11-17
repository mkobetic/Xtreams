"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
subseekend
	| object |
	substreamAtEnd ifTrue: [^self].
	[[substreamAtEnd] whileFalse:
		[object := source get.
		substreamAtEnd := test value: object]]
			on: Incomplete do: [sourceAtEnd := substreamAtEnd := true]
