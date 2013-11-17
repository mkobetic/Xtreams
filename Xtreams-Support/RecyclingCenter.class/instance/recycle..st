"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
