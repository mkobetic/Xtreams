private
streamingWrite: anInteger from: aReadStream
	| count |
	count := 0.
	[[count < anInteger and: [substreamAtEnd not]] whileTrue:
		[self gobble: aReadStream get.
		count := count + 1]]
			on: Incomplete do: [:incomplete |
				destinationAtEnd := substreamAtEnd := true.
				(Incomplete count: count) raise].
	count < anInteger ifTrue:
		[substreamAtEnd := true.
		(Incomplete count: count) raise].
	^anInteger