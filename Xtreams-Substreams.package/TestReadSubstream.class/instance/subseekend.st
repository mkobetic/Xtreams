private
subseekend
	| object |
	substreamAtEnd ifTrue: [^self].
	[[substreamAtEnd] whileFalse:
		[object := source get.
		substreamAtEnd := test value: object]]
			on: Incomplete do: [:ex | sourceAtEnd := substreamAtEnd := true]