recycling
recycle: aCollection
	| queue |
	queue := recycled at: aCollection class ifAbsent: [^self].
	mutex critical: [
	1 to: queue size do: [:index |
		(queue at: index) == nil ifTrue:
			[queue at: index put: aCollection.
			^self]]].