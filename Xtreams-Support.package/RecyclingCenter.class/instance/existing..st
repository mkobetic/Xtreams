"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
