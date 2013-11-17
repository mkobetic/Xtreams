"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: recycling
"
recycle: aCollection
	| queue |
	queue := recycled at: aCollection class.
	mutex critical: [
	1 to: queue size do: [:index |
		(queue at: index) == nil ifTrue:
			[queue at: index put: aCollection.
			mutex signal.
			^self]]]
