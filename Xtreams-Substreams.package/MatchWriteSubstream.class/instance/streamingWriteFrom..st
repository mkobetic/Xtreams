"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteFrom: aReadStream
	| count |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	^[[substreamAtEnd not] whileTrue: [self gobble: aReadStream get. count := count + 1]]
		on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. count ]
