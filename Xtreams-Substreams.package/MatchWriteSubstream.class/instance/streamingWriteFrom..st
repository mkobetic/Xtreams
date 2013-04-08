"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteFrom: aReadStream
	| count |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	^[[substreamAtEnd not] whileTrue: [count := count + (self gobble: aReadStream get)]]
		on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. count ]