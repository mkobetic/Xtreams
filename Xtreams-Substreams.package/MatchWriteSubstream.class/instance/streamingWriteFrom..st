private
streamingWriteFrom: aReadStream
	| count |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	^[[substreamAtEnd not] whileTrue: [self gobble: aReadStream get. count := count + 1]]
		on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. count ]