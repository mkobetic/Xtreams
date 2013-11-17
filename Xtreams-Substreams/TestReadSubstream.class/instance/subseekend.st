"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
subseekend
	| object |
	substreamAtEnd ifTrue: [^self].
	[[substreamAtEnd] whileFalse:
		[object := source get.
		substreamAtEnd := test value: object]]
			on: Incomplete do: [sourceAtEnd := substreamAtEnd := true]
