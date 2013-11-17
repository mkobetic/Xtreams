"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: recycling
"
existing: aClass
	| queue collection |
	queue := recycled at: aClass.
	mutex critical: [
	1 to: queue size do: [:index |
		collection := queue at: index.
		collection == nil ifFalse:
			[queue at: index put: nil.
			mutex signal.
			^collection]]].
	^nil
